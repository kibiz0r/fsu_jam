// gtStatesB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	
	public dynamic class gtStatesB extends gtBehavior
	{
		public var m_states:Array = new Array();
		
		// requires gtMapperB
		public function gtStatesB()
		{
			m_name = "states";
			m_orderWeight = -0.9;
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
			for (var i:int = 0; i < m_states.length; i++)
			{
				var zone = mapper.MapZone(m_states[i].m_name);
				zone.m_currentState = null;
				zone.m_lastState = null;
				Remove(m_states[i].m_name);
			}
			m_states = new Array();
			super.Destructor();
		}
		
		public function Add(n:String,f:Function,zone:String)
		{
			//trace(n);
			var s = new gtState(n,f,gameObject);
			mapper.AddMap(n,s,zone);
			m_states.push(s);
			return s;
		}
		
		public function Remove(n:String)
		{
			var s = mapper.Map(n);
			mapper.RemoveMap(n);
			
			if (s == null)
				trace("State Not Found");
				
			s.Destroy();
		}
		
		public function ReactivateZone(z:String)
		{
			var zone = mapper.GetZone(z);
			Activate(zone.m_currentState);
		}
		
		public function Activate(n:String)
		{
			var zone = mapper.MapZone(n);
			
			if (zone == null)
				trace("State Not Found");
			
			if (n != zone.m_currentState)
			{
				zone.m_lastState = zone.m_currentState;
				zone.m_currentState = n;
				
				Deactivate(zone.m_currentState,true);
				
				if (gameObject.m_report)
					trace(n, "Activated on " + gameObject.type);
					
				mapper.Map(n).Activate();
			}
			else
			{
				mapper.Map(n).Reactivate()
				
				if (gameObject.m_report)
					trace(n, "Reactivated on " + gameObject.type);
			}
		}
		
		public function DeactivateZone(z:String)
		{
			var zone = mapper.GetZone(z);
			Deactivate(zone.m_currentState);
		}
		
		public function Deactivate(n:String,exclude:Boolean = false)
		{
			var zone = mapper.MapZone(n);
			if (exclude)
			{
				var states:Array = zone.GetType("gtState");
				for (var i:int = 0; i < states.length; i++)
				{
					if (states[i].m_name != n)
					{
						if (states[i].Deactivate() && gameObject.m_report)
						{	
							trace(states[i].m_name, "Deactivated on " + gameObject.type);
						}
					}
				}
			}
			else
			{
				if (zone.Get(n).Deactivate())
				{	
					zone.m_lastState = zone.m_currentState;
					zone.m_currentState = null;
					if (gameObject.m_report)
						trace(zone.Get(n).m_name, "Deactivated on " + gameObject.type);
				}
			}
		}
		
		public function CheckState(n:String)
		{
			var zone = mapper.MapZone(n);
			return (zone.m_currentState == n);
		}
		
		public function LastState(zone)
		{
			var zone = mapper.GetZone(zone);
			if (zone.m_lastState == null)
			{
				trace("no last state");
				return;
			}
			else
			{
				gameObject.m_report = true;
				Activate(zone.m_lastState);
				gameObject.m_report = false;
			}
		}
	}
}