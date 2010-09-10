package 
{
	import flash.display.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtTools.*;
	import PinStriper.psSystems.*;
	import flash.events.*;
	
	public dynamic class main extends Sprite
	{
		public static var that:main = null;
		public function main()
		{
			that = this;
			addEventListener(Event.ADDED_TO_STAGE,Added);
		}
		
		public function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,Added);
			gtCore.Setup();
			psEasel.Setup(960,700,1).Top();
			gt.GO(snrGameAppB);
			stage.addEventListener(FocusEvent.FOCUS_IN,FocusIn);
			stage.addEventListener(FocusEvent.FOCUS_OUT,FocusOut);
		}
		
		public function FocusIn(e:FocusEvent)
		{
			//trace(e.target,e.target.parent,e.target.tabIndex,"In");
		}
		
		public function FocusOut(e:FocusEvent)
		{
			//trace(e.target,e.target.parent,e.target.tabIndex,"Out");
		}
	}
}
