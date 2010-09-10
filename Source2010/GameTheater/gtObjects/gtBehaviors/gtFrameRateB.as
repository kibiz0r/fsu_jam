// FPSBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	import flash.text.*;
	import flash.ui.*;
	
	public dynamic class gtFrameRateB extends gtBehavior
	{
		public function gtFrameRateB()
		{
			m_name = "fps";
			m_orderWeight = 0.9;
		}
		
		public override function Awake()
		{
			gameObject.m_fps = new TextField();
			gameObject.m_fps.autoSize = TextFieldAutoSize.LEFT;
			gameObject.m_fps.selectable = false;
			gameObject.m_fps.text = "0"; 
			gameObject.m_fps.x = 0;
			gameObject.m_fps.y = psEasel.that.height - 17;
			var format:TextFormat = new TextFormat();
            //format.font = "Verdana";
            format.color = 0x0066FF;
            //format.size = 10;
            gameObject.m_fps.defaultTextFormat = format;
			
			psEasel.AddCanvas("FPS").addChild(gameObject.m_fps);
			gameObject.states.Add("FPSUpdate",FPSUpdate,"FPS").Update();
		}
		
		public override function Start()
		{
			gameObject.states.Activate("FPSUpdate");
		}
		
		public function FPSUpdate(setting:int)
		{
			if (setting == gtState.UPDATE)
			{
				gameObject.m_fps.x = -(psEasel.that.m_width/2);
				gameObject.m_fps.y = (psEasel.that.m_height/2) - 17;
				gameObject.m_fps.text = int(1000 / gtTime.deltaT).toString(10);
			}
		}
		
		public override function Destructor()
		{
		}
	}
}