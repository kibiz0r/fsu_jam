// gtPropertiesB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	
	public dynamic class gtPropertiesB extends gtBehavior
	{
		public function gtPropertiesB()
		{
			m_name = "properties";
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
			for (var p in this)
			{
				if (p == "m_managed")
					continue;
					
				var prop = mapper.Map(p);
				prop.Destroy();
				this[p] = null;
				delete(this[p]);
			}
			super.Destructor();
		}
		
		public function Set(n:String,s:String,v)
		{
			if (mapper.MapZone(n) == null)
			{
				var zone = mapper.MapZone(s);
				var prop = new gtProperty(gameObject);
				prop.m_name = n;
				prop.m_default = v;
				prop.m_zone = zone;
				this[n] = prop.getset;
				mapper.AddMap(n,prop,zone.m_name);
			}
			
			var p = mapper.Map(n);
			p[s] = v;
			return p;
		}
	}
}

// sample implementation
//public function get t(){return properties.t();}
//public function set t(v){properties.t(v);}

//properties.Set("t","Init",1).Default(10);
//properties.Set("t","Splash",2);

		