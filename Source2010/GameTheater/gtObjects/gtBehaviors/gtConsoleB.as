// ConsoleBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	import flash.events.*;
	
	public dynamic class gtConsoleB extends gtBehavior
	{
		public function gtConsoleB()
		{
			m_name = "console";
			m_orderWeight = 0.9;
		}
		
		public override function Awake()
		{
			var console = gtLog.GetInstance();
			psEasel.AddCanvas("DEBUG").addChild(console);
			psEasel.that.stage.addEventListener(KeyboardEvent.KEY_UP, console.KeyListener);
			psEasel.that.addEventListener(psEvent.RESIZE,console.Resize);
		}
		
		public override function Start()
		{
		
		}
		
		public override function Destructor()
		{
		}
	}
}