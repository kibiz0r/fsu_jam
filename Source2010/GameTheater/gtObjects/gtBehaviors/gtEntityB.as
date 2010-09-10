// gtValuesB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	
	public dynamic class gtEntityB extends gtBehavior
	{
		public const GTENTITY:String = "gtEntity";
		
		public function gtEntityB()
		{
			m_name = "entity";
		}
		
		public override function Awake()
		{
			states.Add("Spawn",Spawn,GTENTITY).SendMessage();
			states.Add("Alive",Alive,GTENTITY).Update().SendMessage();
			states.Add("Dieing",Dieing,GTENTITY).Update();
			states.Add("Dead",Dead,GTENTITY);
		}
		
		public override function Start()
		{
			states.Activate("Spawn");
			
		}
		
		public override function Destructor()
		{
			states.DeactivateZone(GTENTITY);
		}
		
		// Default States
		public function Spawn(setting:int)
		{
			if (setting == gtState.INIT)
			{
				states.Activate("Alive");
			}
		}
		
		public function Alive(setting:int)
		{
			if (setting == gtState.INIT)
			{
			}
			else if (setting == gtState.ENTER)
			{
			}
			else if (setting == gtState.UPDATE)
			{
			}
			else if (setting == gtState.EXIT)
			{
			}
		}
		
		public function Dieing(setting:int)
		{
			if (setting == gtState.ENTER)
			{
				states.Activate("Dead");
			}
		}
		
		public function Dead(setting:int)
		{
			if (setting == gtState.INIT)
			{
				gameObject.Destroy();
			}
		}
	}
}