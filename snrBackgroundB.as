package
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	import flash.display.MovieClip;

	public dynamic class snrBackgroundB extends gtBehavior
	{
		public var m_background = new Array();
		public var m_dummyMovieClip = new MovieClip();
		public var m_vx:Number = 0;
		public var m_vy:Number = 0;
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
			
			states.Add("Play", Play, "Default").Update();
		}
		
		public override function Start()
		{
			states.Activate("Play");
		}
		
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
	}
}