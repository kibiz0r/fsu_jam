package GameTheater.gtTools
{
	import flash.events.*;
	
	public dynamic class gtEvent extends Event
    {
		public static const CONNECTION_LOST:String = "connectionLost";
		public static const VALUE_CHANGED:String = "valueChanged";
		public static const CLEAR_TRIGGERS:String = "clearTriggers";
		public static const CHANGE_STATE:String = "changeState";
		public static const STATE_ACTIVATED:String = "stateActivated";
		public static const STATE_DEACTIVATED:String = "stateDeactivated";
		
		public static const DESTROY_OBJECT:String = "gtDestroyObject";
          
		public function gtEvent( type:String, d = null, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super( type, bubbles, cancelable )
			this.data = d;
		}
    }
}