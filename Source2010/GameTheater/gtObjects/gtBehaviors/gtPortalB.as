// gtPropertiesB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	
	public dynamic class gtPortalB extends gtBehavior
	{
		public var m_portals:Array = new Array();
		
		public function gtPortalB()
		{
			m_name = "portal";
			m_orderWeight = -0.8;
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			for (var i:int = 0; i < m_portals.length; i++)
			{
				Close(m_portals[i].m_name);
				m_portals[i] = null;
			}
			m_portals = new Array();
			super.Destructor();
		}
		
		public function Open(n:String)
		{
			var temp:gtPortal = new gtPortal(n,gameObject);
			this[n+"_portal"] = temp;
			this[n] = temp.outgoing;
			m_portals.push(temp);
			return temp;
		}
		
		public function Close(n:String)
		{
			this[n+"_portal"].Destroy();
			this[n+"_portal"] = null;
			this[n] = null;
		}
	}
}

// sample implementation
//public function get t(){return properties.t();}
//public function set t(v){properties.t(v);}

//properties.Set("t","Init",1).Default(10);
//properties.Set("t","Splash",2);

		