package  {
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public dynamic class snrRavineB extends gtBehavior
	{

		public function snrRavineB()
		{
			m_name = "gob";
		}

		public override function Awake()
		{
			gameObject.content = new Ravine();
			//AddBehavior(gtEntity);
		}
		
		public override function Start()
		{
			
		}
		
		public override function Destructor()
		{
			//gameObject.removeChild(content);
			content = null;
			
			//gameObject.Destroy();
			
			super.Destructor();
		}
		
		public function Alive(s:int)
		{
			
			if (s == gtState.UPDATE)
			{
				if (gameObject.x > psEasel.that.m_width || gameObject.x < -psEasel.that.m_width ||
					gameObject.y > psEasel.that.m_height || gameObject.y < -psEasel.that.m_height)
				{
					trace("test");
					states.Activate("Dieing");
				}
			}
		}
		
		public function OnResetX()
		{
			
		}
		
		public function OnResetY()
		{
			gameObject.y = 0;
		}
	}
	
}
