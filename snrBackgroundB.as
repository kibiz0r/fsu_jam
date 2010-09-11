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

	public dynamic class snrBackgroundB extends gtBehavior
	{
		public var m_background = new Array();
		public var m_dummyMovieClip = new MovieClip();
		public var m_vx:Number = 0;
		public var m_vy:Number = 0;
		public var m_obstacles:Array = new Array();
		public static var that:snrBackgroundB;
		
		public function snrBackgroundB()
		{
			that = this;
			m_name = "gob";
			
			for(var i:int = 0; i < 3; i++)
			{
				m_background.push(new Array());
				
				for(var j:int = 0; j<3; j++)
				{
					var bg:MovieClip = new BackGroundBase();
					bg.x = psEasel.that.m_width * (j - 1);
					bg.y = psEasel.that.m_height * (i - 1);
					m_background[i].push(bg);
					m_dummyMovieClip.addChild(bg);
				}
			}
		}
		
		public override function Awake()
		{
			gameObject.content = m_dummyMovieClip;
			gameObject.actor.Attach(psEasel.GetCanvas("background"));
			
			//states.Add("Play", Play, "Default").Update();
		}
		
		public override function Start()
		{
			//states.Activate("Play");
		}
		
		/*
		public function Play(setting:int)
		{
			if (setting == gtState.INIT)
			{
				
			}
			else if (setting == gtState.UPDATE)
			{
				
				gameObject.y += m_vy * gtTime.deltaT / 1000.0;
				gameObject.x += m_vx * gtTime.deltaT / 1000.0;
				if (gameObject.y >= psEasel.that.m_height || gameObject.y <= -psEasel.that.m_height)
				{
					gameObject.y = 0;
				}
				if (gameObject.x >= psEasel.that.m_width || gameObject.x <= -psEasel.that.m_width)
				{
					gameObject.x = 0;
				}
			}
			else if (setting == gtState.EXIT)
			{
				
			}
		}
		*/
		
		public function UpdateMovements(b_vx, b_vy)
		{
			gameObject.x += b_vx;// been time fixed by player update function
			gameObject.y += b_vy;// been time fixed by player update function
			
			for (var i:int = 0; i < m_obstacles.length; i++)
			{
				m_obstacles[i].x += b_vx;
				m_obstacles[i].y += b_vy;
			}
			
			if (gameObject.y >= psEasel.that.m_height || gameObject.y <= -psEasel.that.m_height)
			{
				gameObject.y = 0;
				OnResetY();
			}
			if (gameObject.x >= psEasel.that.m_width || gameObject.x <= -psEasel.that.m_width)
			{
				gameObject.x = 0;
				OnResetX();
			}
		}
		
		public function OnResetX()
		{
			for (var i:int = 0; i < m_obstacles.length; i++)
			{
				var ob = m_obstacles[i];
				if (ob.x > psEasel.that.m_width || ob.x < -psEasel.that.m_width/2||
					ob.y > psEasel.that.m_height || ob.y < -psEasel.that.m_height)
				{
					m_obstacles.splice(i,1);
					trace(ob.gob,ob.content);
					ob.Destroy();
					i--;
				}
				else
				{
					ob.gob.OnResetX();
				}
			}
			
			var ravine = gt.GO(snrRavineB);
			ravine.x = psEasel.that.m_width;
			m_obstacles.push(ravine);
			ravine.actor.Attach(psEasel.GetCanvas("background"));
			//ravine.visible = false;
		}
		
		public function OnResetY()
		{
			for (var i:int = 0; i < m_obstacles.length; i++)
			{
				m_obstacles[i].gob.OnResetY();
			}
		}
	}
}