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
	import flash.geom.Point;

	public dynamic class snrZombieGrunt extends gtBehavior
	{
		public var playerTarget = null;
		public var index:int;
		
		public static var enemies:Array;
		
		public var m_vx = 0;
		public var m_vy = 0;
		public var m_rotationSpeed = 120;
		public var m_speed = 1000;
		
		public function snrZombieGrunt()
		{
			m_name = "gob";
			
			if(enemies == null)
			{
				enemies = new Array();
			}
			
			index = enemies.count;
			
			enemies.push(gameObject);
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
			
			gameObject.y = 100;
			
			states.Add("Front", Front, "Targeting").Update();
			states.Add("Left", Left, "Targeting").Update();
			states.Add("Right", Right, "Targeting").Update();
		}
		
		public override function Start()
		{
			checkTarget();
			
			states.Activate("Front");
		}
		
		public function checkTarget()
		{
			var ang = Math.atan2((gameObject.y - playerTarget.y),(gameObject.x - playerTarget.x));
			gameObject.rotation = (ang * 180 / Math.PI) - 90;
			
			var testRotate = playerTarget.rotation - gameObject.rotation;
			
			trace(testRotate);
			
			if(testRotate < 0 && testRotate > -80)
			{
				
			}
			
			/*
			if ( testRotate <= -100 && testRotate >= 100)
			{
				states.Activate("Front");
				trace("front");
			}
			else if( testRotate > -100 && testRotate <=0)
			{
				states.Activate("Left");
				trace("Left");
			}
			else if (testRotate > 100 && testRotate < 0)
			{
				states.Activate("Right");
				trace("Right");
			}
			*/
		}
		
		public function Front(s:int)
		{
			if(s == gtState.INIT)
			{
				
			}
			else if(s == gtState.UPDATE)
			{
				/*
				var p = playerTarget.localToGlobal(new Point(0, -25));
				
				var dx:Number = (p.x) - (gameObject.x);
				var dy:Number = (p.y) - (gameObject.y);
				
				var targetAngle:Number = (Math.atan2(dy, dx) * 180 / Math.PI) - 90;
				var delta:Number = m_rotationSpeed * gtTime.deltaT;
				
				if (targetAngle < -180)
					targetAngle += 360; // shortest route
				if (targetAngle > 180)
					targetAngle -= 360;
				if (targetAngle > delta)
					targetAngle = delta; // cap turn speed
				else if (targetAngle < -delta) 
					targetAngle = -delta;
				
				angle += targetAngle;
				
				var angleRad:Number = angle * Math.PI / 180; // convert to radians
				var cosa:Number = Math.cos(angleRad);
				var sina:Number = Math.sin(angleRad);
				m_vx += (cosa * m_speed) * gtTime.deltaT;
				m_vy += (sina * m_speed) * gtTime.deltaT;
				//if (velocity.x > maxThrust)
					//velocity.x = maxThrust; // cap
				//else if (velocity.x < -maxThrust) velocity.x = -maxThrust;
				//if (velocity.y > maxThrust) velocity.y = maxThrust;
				//else if (velocity.y < -maxThrust) velocity.y = -maxThrust;

				//trace(p);
				
				gameObject.x += m_vx;
				gameObject.y += m_vy;
				*/
				checkTarget();
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
				checkTarget();
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
				
				
				checkTarget();
			}
			else if(s == gtState.EXIT)
			{
				
			}
		}
	}
}
