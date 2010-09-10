// DataHouse.as
package GameTheater.gtSystems
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public dynamic class gtPHP
	{ 
		public static var m_report:Boolean = false;
	
		private static var m_amfphp:NetConnection;
		private static var m_responder:Responder;
		
		private static var m_requests:Array;
		private static var m_calls:Array;
				
		public static function Connect(link:String)
		{
			m_amfphp = new NetConnection(); 
			m_amfphp.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            m_amfphp.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            m_amfphp.connect(link);
			m_responder = new Responder(amfphpResult,amfphpFault);
			m_requests = new Array();
			m_calls = new Array();
		}
		
		public static function Call(fName:String, f:Function, ...p)
		{
			var c = new Object();
			c.fName = fName;
			c.f = f;
			c.p = p;
			m_calls.push(c);
			
			if (m_requests.length == 0)
				MakeCall();
		}
		
		public static function MakeCall()
		{
			if (m_calls.length > 0)
			{
				if (m_report)
					trace("calling ----------------------------------------");
				
				var service:String = "";
				for (var i:int = 0; i < m_calls.length; i++)
				{
					var c = null
					if (service == "")
					{
						c = m_calls.shift();
						service = c.fName.split(".")[0];
						i--;
					}
					else
					{
						if (m_calls[i].fName.split(".")[0] == service)
						{
							c = m_calls.shift();
							i--;
						}
						else
						{
							if (m_report)
								trace("postponing call",m_calls[i].fName);
							continue;
						}
					}
					
					if (m_report)
						trace("call",c.fName);
				
					var temp = new Object();
					temp.callBack = c.f;
					temp.functionName = c.fName;
					m_requests.push(temp);
					if (c.p.length == 0)
						m_amfphp.call(c.fName,m_responder);
					else
					{
						c.p.unshift(m_responder);
						c.p.unshift(c.fName);
						m_amfphp.call.apply(m_amfphp,c.p);
						c.fName = "";
						c.f = null;
						c.p = null;
					}
					break;
				}
				
				if (m_report)
					trace("-------------------------------------------------");
			}
		}
		
		public static function Clear()
		{
			for (var i:uint = 0; i < m_requests.length; i++)
			{
				m_requests[i].callBack = null; 
				m_requests[i] = 0;
			}
			m_requests = new Array();
		}
		
		public static function SQL_Get(table:String, f:Function)
		{
			Call("gtDBConnector.Get",f,table);
		}
		
		public static function SQL_GetBy(table:String,columns:Array)
		{
			//SELECT firstName, lastName FROM UserInfo WHERE id = '$id'"
		}
		
		public static function SQL_Add()
		{
			
		}
		
		public static function SQL_Delete()
		{
			
		}
		
		public static function SQL_Modify()
		{
			
		}
		
		// turns arrays into flash objects
		private static function ParseDatabaseResult(o:Object)
		{
			var a:Array = new Array();
			for (var i:int = 0; i < o.serverInfo.initialData.length; i++)
			{
				var temp = new Object();
				for (var j:int = 0; j < o.serverInfo.columnNames.length; j++)
				{
					temp[o.serverInfo.columnNames[j]] = o.serverInfo.initialData[i][j];
				}
				a.push(temp);
			}
			return a;
		}
		
		public static function amfphpResult(o:Object)
		{
			if (o == null)
			{
				trace("php is broke i got back null you should check that");
				return
			}
			
			if (!o.hasOwnProperty("functionName"))
			{
				trace("you broke it by not using fix return this is what i got:",o);
				return;
			}
			
			for (var i:uint = 0; i < m_requests.length; i++)
			{
				if (o.functionName == m_requests[i].functionName)
				{
					if (m_report)
						trace("responce",o.functionName);
				
					if (o.returnType == "DataBase")
					{
						o.data = ParseDatabaseResult(o.data);
						
					}
					else if (o.returnType == "String")
					{
						
					}
					else if (o.returnType == "int")
					{
						
					}
					else // if the type is not recognized
					{
						
					}
					m_requests[i].callBack(o);
					
					m_requests.splice(i,1);
					MakeCall();
					return;
				}
			}
			trace("no listener found you messed up " + o.functionName);
		}
		
		public static function amfphpFault(o:Object)
		{
			trace("broken fault thing");
			for (var i in o)
			{
				trace(o[i]);
				gtLog.Add(o[i]);
			}
		}

        private static function netStatusHandler(event:NetStatusEvent):void 
		{
			trace("netStatusHandler: " + event.info.code);
			gtLog.Add("netStatusHandler: " + event.info.code);
			Clear();
			gtCore.DispatchMessage(new gtEvent(gtEvent.CONNECTION_LOST));
        }

        private static function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event.text);
			gtLog.Add("securityErrorHandler: " + event.text);
        }
  	}
}