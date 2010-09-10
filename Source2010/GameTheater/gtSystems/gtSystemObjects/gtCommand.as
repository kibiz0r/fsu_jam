//psCommand
package GameTheater.gtSystems.gtSystemObjects
{
	import GameTheater.gtSystems.*;
	
	public class gtCommand
	{
		public var m_command:String;
		
		public var m_params:Array;
		public var m_paramTypes:Array;
		
		public var m_man:Array;
		
		public var m_function:Function = null;
		
		public function gtCommand()
		{
			m_params = new Array();
			m_paramTypes = new Array();
			m_man = new Array();
		}
		
		public function Init(c:String,f:Function)
		{
			m_command = c;
			m_function = f;
		}
		
		public function AddParameter(n:String,t)
		{
			m_params.push(n);
			m_paramTypes.push(t);
		}
		
		public function Perform(p:String):String
		{
			return m_function(BreakUpParams(p));
		}
		
		public function Add_man(s:String)
		{
			m_man.push(s);
		}
		
		public function man()
		{
			for(var i:int = 0; i< m_man.length; i++)
				gtLog.Add(m_man[i]);
		}
		
		public function BreakUpParams(p:String):Object
		{
			var param = new Object();
			
			if (!p)
				return param;
			
			var paramValues:Array = p.split(",");
			for (var i:int = 0; i < paramValues.length; i++)
			{
				if (i < m_params.length)
					param[m_params[i]] = paramValues[i] as m_paramTypes[i];
				else
				{
					param["p"+(i-m_params.length)] = paramValues[i];
				}
			}			
			return param;
		}
	}
}