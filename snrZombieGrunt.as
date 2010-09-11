package
{
	import flash.events.*;
	import flash.display.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;

	public dynamic class snrZombieGrunt extends gtBehavior
	{
		public var playerTarget = null;
		
		public function snrZombieGrunt()
		{
			m_name = "gob";
		}
		
		public override function Awake()
		{
			gameObject.content = new Zombie_Grunt();
			
			gameObject.actor.Attach(psEasel.GetCanvas("game_space"));
			
			/*
			var side = (int)(Math.random() * 3);
			
			if(side == 0)
			{
				// top
				gameObject.x = (Math.random() * 750) - 350;
				gameObject.y = -275;
			}
			else if (side == 1)
			{
				// right
				gameObject.y = (Math.random() * 550) - 250;
				gameObject.x = 375;
			}
			else if (side == 2)
			{
				// bottom
				gameObject.x = (Math.random() * 750) - 350;
				gameObject.y = 275;
			}
			else if (side == 3)
			{
				//left 
				gameObject.y = (Math.random() * 550) - 250;
				gameObject.x = -375;
			}
			//*/
			
			gameObject.y = 300;
			
			states.Add("Front", Front, "Targeting").Update();
			states.Add("Left", Left, "Targeting").Update();
			states.Add("Right", Right, "Targeting").Update();
		}
		
		public override function Start()
		{
			var ang = Math.atan2((gameObject.y - playerTarget.y),(gameObject.x - playerTarget.x));
			trace(ang);
			gameObject.rotation = (ang * 180 / Math.PI) - 90;
			
			states.Activate("Front");
		}
		
		public function Front(s:int)
		{
			if(s == gtState.INIT)
			{
				
			}
			else if(s == gtState.UPDATE)
			{
				var ang = ((Math.atan2((gameObject.y - playerTarget.y),(gameObject.x - playerTarget.x))) * 180 / Math.PI) - 90;
				gameObject.rotation = ang;
				trace(ang);
			}
			else if(s == gtState.EXIT)
			{
				
			}
		}
		
		public function Left(s:int)
		{
			if(s == gtState.INIT)
			{
				
			}
			else if(s == gtState.UPDATE)
			{
				
			}
			else if(s == gtState.EXIT)
			{
				
			}
		}
		
		public function Right(s:int)
		{
			if(s == gtState.INIT)
			{
				
			}
			else if(s == gtState.UPDATE)
			{
				
			}
			else if(s == gtState.EXIT)
			{
				
			}
		}
	}
}