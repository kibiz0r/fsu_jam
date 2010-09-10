// gtBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	
	public dynamic class gtMapperB extends gtBehavior
	{
		private var m_zones:Array = new Array;
		private var m_map:Array = new Array;	
		
		public function gtMapperB()
		{
			m_name = "mapper";
			m_orderWeight = -1;
			//m_recycle = true;
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			for (var zone in m_zones)
			{
				m_zones[zone].Destroy();
				m_zones[zone] = null;
				delete(m_zones[zone]);
			}
			m_zones = new Array();
			
			for (var obj in m_map)
			{
				m_map[obj] = null;
				delete(m_map[obj]);
			}
			m_map = new Array();
			
			super.Destructor();
		}
		
		public function AddMap(n:String,o:Object,zone:String):gtZone
		{
			m_map[n] = GetZone(zone);
			m_map[n].Add(n,o);
			return m_map[n];
		}
		
		public function RemoveMap(n:String)
		{
			m_map[n].Remove(n);
			m_map[n] = null;
			delete(m_map[n]);
		}
		
		// returns zone by name
		public function GetZone(zone:String):gtZone
		{
			if (m_zones[zone] == null)
			{
				m_zones[zone] = new gtZone(zone,this);
			}
			return m_zones[zone];
		}
		
		//returns object by name
		public function Map(n:String):Object
		{
			return m_map[n].Get(n);
		}
		
		// returns zone by object name
		public function MapZone(n:String):gtZone
		{
			return m_map[n];
		}
	}
}