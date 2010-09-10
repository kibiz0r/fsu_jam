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
	
	public dynamic class snrGameAppB extends gtBehavior
	{
		public const APP:String = "snrGameAppB";
		
		public static var mainCamera:gtCameraB = null;
		
		public function snrGameAppB()
		{
			m_name = "app";
		}
		
		public override function Awake()
		{
			psEasel.AddCanvas("background");
			psEasel.AddCanvas("main",psCanvas.CANVAS_SCALE);
			psEasel.AddCanvas("ui",psCanvas.CANVAS_SCALE);
			
			actor.Attach(psEasel.GetCanvas("main"));
			
			AddBehavior(gtConsoleB);
			//AddBehavior(gtFrameRateB);
			//AddBehavior(gtMemoryB);
			AddBehavior(gtScreenB);
			mainCamera = AddBehavior(gtCameraB).SetCanvas("main");
			
			//screens.Add("loading",gt.GO(snrLoaderB));
			screens.Add("game",gt.GO(snrGameB));
		}
		
		public override function Start()
		{
			gtLog.Add("SNRGame Version 0.01");
			screens.Switch("game");
		}
	}
}
