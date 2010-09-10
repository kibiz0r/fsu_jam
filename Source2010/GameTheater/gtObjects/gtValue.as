//gtState
package GameTheater.gtObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public dynamic class gtValue
	{
		public var m_name:String = "";
		public var m_value = 0;
		public var m_min = 0;
		public var m_max = 0;
		public var m_floor = 0;
		public var m_total = 0;
		public var m_clampMin:Boolean = false;
		public var m_clampMax:Boolean = false;
		public var m_ratio:Boolean = false;
		public var m_gameObject = null;
		
		public function gtValue(n,v,go)
		{
			m_name = n;
			m_value = v;
			m_gameObject = go;
		}
		
		public function Destroy()
		{
			m_name = "";
			m_value = 0;
			m_gameObject = null;
			m_min = 0;
			m_max = 0;
			m_floor = 0;
			m_total = 0;
			m_clampMin = false;
			m_clampMax = false;
			m_ratio = false;
		}
		
		public function Min(v)
		{
			m_clampMin = true;
			m_min = v;
			getset(m_value);
			return this;
		}
		public function Max(v)
		{
			m_clampMax = true;
			m_max = v;
			getset(m_value);
			return this;
		}
		
		public function Floor(v)
		{
			if (v < m_total)
				m_floor = v;
			else
				trace("floor must be smaller than total");
			return this;
		}
		
		public function Total(v)
		{
			m_ratio = true;
			m_total = v;
			return this;
		}
		
		public function get ratio()
		{
			if (!m_ratio)
			{
				trace(m_name + " not set up for ratio");
				return 1;
			}
			
			return (m_value-m_floor)/(m_total-m_floor);
		}
		
		public function set ratio(v)
		{
			if (!m_ratio)
			{
				trace(m_name + " not set up for ratio");
				return m_value;
			}
			
			return (getset(((m_total-m_floor)*v)+m_floor)-m_floor)/(m_total-m_floor);
		}
		
		public function get value()
		{
			return getset();
		}
		
		public function set value(v)
		{
			return getset(v);
		}
		
		public function getset(v = null)
		{
			if (v != null)
			{
				m_value = v;
				if (m_clampMin)
					m_value = Math.max(m_min,m_value);
				
				if (m_clampMax)
					m_value = Math.min(m_max,m_value);
			}
			return m_value;
		}
	}
}