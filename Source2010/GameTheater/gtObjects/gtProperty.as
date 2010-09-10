//gtState
package GameTheater.gtObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public dynamic class gtProperty extends gtObject
	{
		public var m_name:String = "";
		public var m_default = null;
		public var m_zone = "";
		public var m_gameObject = null;
		
		public function gtProperty(go)
		{
			m_gameObject = go;
		}
		
		public override function Destructor()
		{
			for (var p in this)
			{
				this[p] = null;
				delete(this[p]);
			}
			
			m_name = "";
			m_default = null;
			m_zone = "";
			m_gameObject = null;
			super.Destructor();
		}
		
		public function Default(v)
		{
			m_default = v;
			return this;
		}
		
		/*public function get value()
		{
			var zone = m_gameObject.mapper.MapZone(m_name);
			if (zone == null)
			{
				trace("zone mapping not found");
				return m_default;
			}
			
			var s = zone.m_currentState;
			if (s == null || this[s] == null)
				return m_default;
			else
				return this[s];
		}*/
		
		public function getset(v = null)
		{
			var zone = m_gameObject.mapper.MapZone(m_name);
			if (zone == null)
			{
				trace("zone mapping not found");
				return m_default;
			}
				
			var s = zone.m_currentState;
			if (v == null)
			{
				if (s == null || this[s] == null)
					return m_default;
				else
					return this[s];
			}
			else
			{
				if (s == null || this[s] == null)
				{
					trace("attempting to change default value is this what you want?");
					return m_default;
				}
				else
				{
					this[s] = v;
					return this[s];
				}
			}
			
		}
	}
}