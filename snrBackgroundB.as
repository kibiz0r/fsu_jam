package
{
	import GameTheater.gtObjects.gtBehavior;
	import PinStriper.psSystems.*;
	import flash.display.MovieClip;

	public dynamic class snrBackgroundB extends gtBehavior
	{
		public var m_background = new Array();
		public var m_dummyMovieClip = new MovieClip();
		
		public function snrBackgroundB()
		{
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
		}
		
		public override function Start()
		{
			
		}
	}
}