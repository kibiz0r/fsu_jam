// gtPropertiesB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import PinStriper.psSystems.*;
	import GameTheater.gtObjects.*;
	
	public dynamic class gtScreenB extends gtBehavior
	{
		public var m_screenName:String = "";
		
		
		public function gtScreenB()
		{
			m_name = "screens";
		}
		
		public override function Awake()
		{
			link.Add("screen");
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			link.Remove("screen");
			trace("screenB not being cleaned up");
			super.Destructor();
		}
		
		public function Show()
		{
			actor.Attach(link.screen.parent);
			SendMessage("Show");
		}
		
		public function Hide()
		{
			actor.Detach();
			SendMessage("Hide");
		}
		
		public function Add(n:String,o:gtGameObject,zoneName:String = "gtScreen")
		{
			if (o.screens == null)
				o.AddBehavior(gtScreenB);
			o.screens.m_screenName = n;
			o.link.screen.parent = gameObject;
			var zone = mapper.AddMap(n,o,zoneName);
		}
		
		public function HideZone(zoneName:String = "gtScreen")
		{
			var zone = mapper.GetZone(zoneName);
			if (zone == null)
			{
				trace("get zone failed in hide zone");
				return;
			}
			
			if (zone.m_currentScreen != null)
			{
				var temp = mapper.Map(zone.m_currentScreen);
				temp.screens.Hide();
			}
			zone.m_currentScreen = null;
		}
		
		public function Switch(s:String)
		{
			var zone = mapper.MapZone(s);
			if (zone == null)
			{
				trace("zone map failed in switch");
				return;
			}
			
			if (zone.m_currentScreen == s)
			{
				//trace("screen " + s + " already shown");
				return;
			}
			
			var screen = mapper.Map(s);
			if (screen == null)
			{
				trace("screen not found");
				return;
			}
			
			if (zone.m_currentScreen != null)
			{
				var temp = mapper.Map(zone.m_currentScreen);
				temp.screens.Hide();
				//temp.screens.DispatchMessage("Hide");
			}
			zone.m_currentScreen = s;
			screen.screens.Show();
			//screen.screens.DispatchMessage("Show");
		}
		
		public function ParentSwitch(s:String)
		{
			link.screen.parent.screens.Switch(s);
		}
	}
}