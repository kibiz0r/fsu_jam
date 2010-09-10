// ConsoleBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	import flash.events.*;
	
	public dynamic class gtVerletMotionB extends gtBehavior
	{
		public function gtVerletMotionB()
		{
			m_name = "motion";
		}
		
		public override function Awake()
		{
			gameObject.m_vx = 0;
			gameObject.m_vy = 0;
			states.Add("DoMotion", DoMotion, "MOTION").Update();
		}
		
		public override function Start()
		{
			gameObject.states.Activate("DoMotion");
		}
		
		public function DoMotion(setting:int)
		{
			if (setting == gtState.UPDATE)
			{
				gameObject.x += gameObject.m_vx * gtTime.deltaT * 0.001;
				gameObject.y += gameObject.m_vy * gtTime.deltaT * 0.001;
			}
			
		}
		
		public override function Destructor()
		{
			
		}
	}
}