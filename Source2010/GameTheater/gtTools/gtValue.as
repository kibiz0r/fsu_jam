package GameTheater.gtTools
{
	import flash.events.*;
	
	public dynamic class gtEvent extends Event
    {
		public static const CLEAR_TRIGGERS:String = "clearTriggers";
		public static const CHANGE_STATE:String = "changeState";
		public static const STATE_ACTIVATED:String = "stateActivated";
		public static const STATE_DEACTIVATED:String = "stateDeactivated";
          
		public function gtEvent( type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super( type, bubbles, cancelable )
		}
    }
}