//psEvent
package PinStriper.psTools
{
	import flash.events.*;
	
	public class psEvent extends Event
     {
          public static const RESIZE:String = "Resize";
          
          public function psEvent( type:String, bubbles:Boolean = true, cancelable:Boolean = false)
          {
               super( type, bubbles, cancelable )
          }
     }
}