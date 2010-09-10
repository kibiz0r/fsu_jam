//gtStateGroup
package GameTheater.gtObjects
{
	import GameTheater.gtSystems.*;
	
	public dynamic class gtZone
	{
		public var m_name:String = "default";
		
		public var m_objects:Array = new Array();
		public var m_types:Array = new Array();
		
		public function gtZone(n,m)
		{
			m_name = n;
		}
		
		public function Destroy()
		{
			m_name = "";
			
			for (var obj in m_objects)
			{
				m_objects[obj] = null;
				delete(m_objects[obj]);
			}
			m_objects = new Array();
			
			for (var t in m_types)
			{
				for (var i:int = 0; i < m_types[t].length; i++)
				{
					m_types[t][i] = null;
				}
				m_types[t] = null;
				delete(m_types[t]);
			}
			m_types = new Array();
		}
		
		public function GetType(t:String):Array
		{
			if (m_types[t] == null)
			{
				m_types[t] = new Array();
			}
			return m_types[t];
		}
		
		public function Add(n,o)
		{
			if (o["type"] != null)
			{
				GetType(o.type).push(o);
			}
			m_objects[n] = o;
		}
		
		public function Remove(n)
		{
			var o = m_objects[n];
			if (o["type"] != null)
			{
				var a = GetType(o.type);
				a.splice(a.indexOf(o),1);
			}
			m_objects[n] = null;
			delete(m_objects[n]);
		}
		
		public function Get(n)
		{
			return m_objects[n];
		}
		
		
	}
}