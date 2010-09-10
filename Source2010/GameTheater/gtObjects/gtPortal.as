//gtState
package GameTheater.gtObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public dynamic class gtPortal extends gtObject
	{
		public static var m_portals:Object = new Object();
		
		public var m_name:String = "";
		public var m_gameObject = null;
		
		public var m_in:Boolean = false;
		
		public function gtPortal(n,go)
		{
			m_name = n;
			m_gameObject = go;
		}
		
		public override function Destructor()
		{
			m_name = "";
			m_gameObject = null;
			if (m_in)
				m_portals[m_name].splice(m_portals[m_name].indexOf(this),1);
		}
		
		public function In()
		{
			m_in = true;
			if (m_portals[m_name] == null)
				m_portals[m_name] = new Array();
			m_portals[m_name].push(this);
		}
		
		public function outgoing(v = null)
		{
			if (m_portals[m_name])
			{
				for (var i:int = 0; i < m_portals[m_name].length; i++)
				{
					if (m_portals[m_name][i] != this)
						m_portals[m_name][i].incoming(v);
				}
			}
			else
				trace("no portals open to recieve data");
		}
		
		public function incoming(v = null)
		{
			if (m_in)
				m_gameObject.SendMessage(m_name,v,m_gameObject.portal);
			else
				trace("i should not be getting incoming data");
		}
	}
}