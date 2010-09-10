package
{
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;
	
	import GameTheater.gtObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtGameObjects.*;
	import GameTheater.gtGameObjects.gtApps.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public dynamic class main extends gtGameApp
	{
		public static var that:main;
		
		public function main()
		{
			that = this;
		}
		
		//-----------------------------------------------------------------------------------------
		
		public override function AttachedListener(e:Event)
		{
			psEasel.SetDynamicResize(false);
			psEasel.SetMode(psEasel.STANDARD);
			psEasel.Setup(550,400,275,200);
			
			super.AttachedListener(e);
			
			AddBehavior(gtConsoleB);
			AddBehavior(gtFrameRateB);
			AddBehavior(gtMemoryB);
			
			states.Activate("Init");
		}
		
		public override function Init(setting:int)
		{
			super.Init(setting);
			if (setting == gtState.INIT)
			{
				gtLog.Add("Version 1.01");
			}
		}
	}
}

