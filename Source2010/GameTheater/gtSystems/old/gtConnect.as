// gtConnect.as 
package GameTheater.gtSystems
{	
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import flash.events.*;
	import flash.net.*;
	
	import AnyOpolis.*;
	import PinStriper.*;
	import PinStriper.psTools.*;
	import GameTheater.gtSystems.*;
	
	public class gtConnect
	{		
	
		public static var m_instance = null;
		
		public var m_sfs:SmartFoxClient;
		public var m_extension:String = "dbFerrisOpolis"
		public var m_username:String;
		public var m_password:String;
		public var m_email:String;
		public var m_active:String;
		public var m_ip:String;
		public var m_connected:Boolean = false;
		public var m_connectionFailed:Boolean = false;
		public var m_loggedIn:Boolean = false;
		public var m_roomJoined:Boolean = false;
		public var m_autoLoadCount:Number = 0;
		public var m_autoLoaded:Boolean = false;
		public var m_loaded:Array;
		public var m_character:String;

	
		public function gtConnect()
		{
			m_sfs = new SmartFoxClient(true);
			m_sfs.debug = false;
			m_username = "j1";
			m_password = "t1";
			m_email = "";
			m_active = "";
			m_character = "Girl";
			m_ip = "127.0.0.1";
			//m_ip = "jfreeney.homeip.net";
			//m_ip = "colby"
			
			// Register for SFS events
			m_sfs.addEventListener(SFSEvent.onConnection, onConnection);
			m_sfs.addEventListener(SFSEvent.onConnectionLost, onConnectionLost);
			m_sfs.addEventListener(SFSEvent.onLogin, onLogin);
			m_sfs.addEventListener(SFSEvent.onRoomListUpdate, onRoomListUpdate);
			m_sfs.addEventListener(SFSEvent.onJoinRoom, onJoinRoom);
			m_sfs.addEventListener(SFSEvent.onJoinRoomError, onJoinRoomError);
			m_sfs.addEventListener(SFSEvent.onExtensionResponse, onExtensionResponse);
			m_sfs.addEventListener(SFSEvent.onUserEnterRoom, onUserEnterRoom);
			m_sfs.addEventListener(SFSEvent.onUserLeaveRoom, onUserLeaveRoom);
			m_sfs.addEventListener(SFSEvent.onUserVariablesUpdate, onUserVariablesUpdate);
			m_sfs.addEventListener(SFSEvent.onUserCountChange, onUserCountChange);
			m_sfs.addEventListener(SFSEvent.onPublicMessage, onPublicMessage);
			m_sfs.addEventListener(SFSEvent.onPrivateMessage, onPrivateMessage);
			m_sfs.addEventListener(SFSEvent.onModeratorMessage, onModeratorMessage);
			m_sfs.addEventListener(SFSEvent.onAdminMessage, onAdminMessage);
			
			// Register for generic errors
			m_sfs.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError)
			m_sfs.addEventListener(IOErrorEvent.IO_ERROR, onIOError)
			
			m_loaded = new Array();
		}
		
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new gtConnect();

			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}
		
		public function Connect():void
		{
			m_connectionFailed = false;
			m_sfs.smartConnect = false;
			if (!m_sfs.isConnected)
				m_sfs.connect(m_ip);
			else
				gtLog.Add("You are already connected!");
		}
		
		public function Disconnect():void
		{
			m_sfs.disconnect();
		}
		
		public function Connected():Boolean
		{
			return m_sfs.isConnected;
		}
		
		public function ConnectionFailed():Boolean
		{
			return m_connectionFailed;
		}
		
		public function Login()
		{
			m_sfs.login("ferris-opolis",m_username,m_password);
		}
		
		public function LoggedIn():Boolean
		{
			return m_loggedIn;
		}
		
		public function ChangeRoom(room:String)
		{
			m_sfs.joinRoom(room);
		}
		
		public function RoomJoined():Boolean
		{
			return m_roomJoined;
		}
		
		public function AutoLoad()
		{
			var dh = gtDataHouse.GetInstance();
			var params = {};
			
			for (var i = 0; i < dh.manifest.m_children["db"][0].m_children["table"].length; i++)
			{
				params = {};
				params.table = dh.manifest.m_children["db"][0].m_children["table"][i].m_attributes["id"];
				
				params.num_columns = dh.manifest.m_children["db"][0].m_children["table"][i].m_children["column"].length;
				params.columns = {};
				for (var j = 0; j < params.num_columns; j++)
				{
					params.columns[j] = dh.manifest.m_children["db"][0].m_children["table"][i].m_children["column"][j].m_attributes["id"];
				}
				
				m_autoLoadCount++;
				m_sfs.sendXtMessage(m_extension, "load", params)
			}
		}
		
		public function Load(table:String,p:Array)
		{
			var params = {};
			
			params.load = true;
			params.table = table;
			params.num_columns = p.length;
			params.columns = {};
			for(var i = 0; i < p.length; i++)
			{
				params.columns[i] = p[i];
			}
			m_sfs.sendXtMessage(m_extension, "load", params)			
		}
		
		public function Add(table:String,c:Array,d:Array)
		{
			var params = {};
			
			params.table = table;
			params.num_columns = c.length;
			params.columns = {};
			params.data = {};
			for(var i = 0; i < c.length; i++)
			{
				params.columns[i] = c[i];
				params.data[i] = d[i];
			}
			m_sfs.sendXtMessage(m_extension, "add", params)			
		}
		
		public function Modify(table:String,c:Array,d:Array,where:String, what:String)
		{
			var params = {};
			
			params.table = table;
			params.num_columns = c.length;
			params.columns = {};
			params.data = {};
			for(var i = 0; i < c.length; i++)
			{
				params.columns[i] = c[i];
				params.data[i] = d[i];
			}
			params.where = where;
			params.what = what;
			m_sfs.sendXtMessage(m_extension, "modify", params)			
		}
		
		public function IsLoaded(what:String):Boolean
		{
			if (m_loaded[what])
				return true;
			else
				return false;
		}
		
		public function onExtensionResponse(evt:SFSEvent):void
		{
			if (evt.params.type == "xml")
			{
				if (evt.params.dataObj._cmd == "mail")
				{
					if (evt.params.dataObj.success == true)
						gtLog.Add("e-mail sent to " + evt.params.dataObj.params.to);
				}
				else if (evt.params.dataObj._cmd == "load")
				{
					if (evt.params.dataObj.db.length == 0)
					{
						m_autoLoaded = false;
						gtLog.Add("Auto-Load Failed");
						return;
					}
					m_autoLoadCount--;
					//gtLog.Add("recieved: " + evt.params.dataObj.db.length)
					var data:Array = new Array();
					for (var i = 0; i < evt.params.dataObj.db.length; i++)
					{
						var obj = new Object;
						for (var j = 0; j < evt.params.dataObj.params.num_columns; j++)
						{
							obj[evt.params.dataObj.params.columns[j]] = evt.params.dataObj.db[i][evt.params.dataObj.params.columns[j]];
							//gtLog.Add(evt.params.dataObj.params.columns[j],evt.params.dataObj.db[i][evt.params.dataObj.params.columns[j]])
						}
						data.push(obj);
						if (obj.id)
							data[obj.id] = obj;
						
						gtDataHouse.GetInstance().AddData(evt.params.dataObj.params.table,data);
					}
					if (m_autoLoadCount == 0)
						m_autoLoaded = true;
					m_loaded[evt.params.dataObj.params.table] = true;
				}
			}
		}
		
		public function onConnection(evt:SFSEvent):void
		{
			var success:Boolean = evt.params.success;
			
			if (success)
			{
				gtLog.Add("Connection successfull!");
				m_connected = true;
			}
			else
			{
				m_connectionFailed = true;
				gtLog.Add("Connection failed!");
			}
		}
		
		public function onConnectionLost(evt:SFSEvent):void
		{
			gtLog.Add("Connection lost!");
			m_connected = false;
			m_connectionFailed = true;
		}
		
		public function onLogin(evt:SFSEvent):void
		{
			if (evt.params.success)
			{
				m_loggedIn = true;
				gtLog.Add(evt.params.name + " logged in");
			}
			else
			{
				gtLog.Add("Login failed. Reason: " + evt.params.error + " " + evt.params.name);
			}
		}
		
		public function onRoomListUpdate(evt:SFSEvent):void
		{			
			// Tell the server to auto-join us in the default room for this Zone
			m_sfs.autoJoin();
		}
		
		// ERRORS *********************************************************************
		public function onJoinRoomError(evt:SFSEvent):void
		{
			gtLog.Add("Problems joining default room. Reason: " + evt.params.error);	
		}
		
		public function onSecurityError(evt:SecurityErrorEvent):void
		{
			gtLog.Add("Security error: " + evt.text);
		}
		
		public function onIOError(evt:IOErrorEvent):void
		{
			gtLog.Add("I/O Error: " + evt.text);
		}
		
		public var m_roomId:Number = 0;
		public var m_room;
		
		public function onJoinRoom(evt:SFSEvent):void
		{
			m_roomJoined = true;
			
			m_roomId = evt.params.room.getId();
			m_room = evt.params.room;
			
			if (m_room.getName() == "load")
				return;
				
			if (m_room.getName() == "edit")
				return;
				
			var m_userList = evt.params.room.getUserList();
			
			
			for (var i:String in m_userList)
			{
				var user	 		= m_userList[i]
				var uName:String 	= user.getName()
				var uId:Number		= user.getId()
				
				if (uName != m_username)
				{
					var uVars:Object = user.getVariables();
					
					//Director.GetInstance().NewCharacter(getClassByAlias(uVars.char),uName,"NET");
					//Director.GetInstance().PlaceCharacter(uName,"campus",uVars.px,uVars.py);
				}
			}
			
			//Director.GetInstance().NewCharacter(getClassByAlias(m_character),m_username,"PLAYER");
			//Director.GetInstance().PlaceCharacter(m_username,"campus",18,15);
			//m_sfs.setUserVariables({px:2, py:6, moving:false, char:m_character})
		}
		
		public function onUserEnterRoom(evt:SFSEvent)
		{
			}
		
		public function onUserLeaveRoom(evt:SFSEvent)
		{	
			//Director.GetInstance().RemoveCharacter(evt.params.userName);
		}
		
		public function onUserVariablesUpdate(evt:SFSEvent)
		{
			var uVars:Object = evt.params.user.getVariables()
			if (uVars.moving)
			{
				//Director.GetInstance().MoveCharacter(evt.params.user.getName(),uVars.px,uVars.py);
			}
			else
			{
				//if (!Director.GetInstance().HasCharacter(evt.params.user.getName()))
				//{
					//Director.GetInstance().NewCharacter(getClassByAlias(uVars.char),evt.params.user.getName(),"NET");
					//Director.GetInstance().PlaceCharacter(evt.params.user.getName(),"campus",uVars.px,uVars.py);
				//}
			}
		}
		
		public function onUserCountChange(evt:SFSEvent)
		{
		}
		
		public function onPublicMessage(evt:SFSEvent)
		{	
			//HUD.GetInstance().PostInfo(evt.params.sender.getName() + ": " + evt.params.message);
		}
		
		public function onPrivateMessage(evt:SFSEvent)
		{	
			//HUD.GetInstance().PostInfo(evt.params.sender.getName() + ": " + evt.params.message);
		}
		
		public function onModeratorMessage(evt:SFSEvent)
		{	
			//HUD.GetInstance().PostInfo(evt.params.sender.getName() + ": " + evt.params.message);
		}
		
		public function onAdminMessage(evt:SFSEvent)
		{	
			//HUD.GetInstance().PostInfo(evt.params.message);
		}
		
		public function SendChatMsg(txt:String)
		{
			if (txt.length > 0)
			{
				m_sfs.sendPublicMessage(txt);
			}
		}
		
		public function SendMail(to:String,subject:String,message:String)
		{
			var params = {};
			
			params.to = to;
			params.subject = subject;
			params.message = message;
			
			m_sfs.sendXtMessage(m_extension, "mail", params)			
		}
	}
}















