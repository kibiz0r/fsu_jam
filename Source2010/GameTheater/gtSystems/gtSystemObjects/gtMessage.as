//gtMessage
package GameTheater.gtSystems.gtSystemObjects
{
	import flash.events.*;
	
	public class gtMessage extends Event
     {
          public static const GAME_MESSAGE:String = "GameMessage";
          
		  public var m_property:String;

          public function gtMessage( type:String, cp:String, bubbles:Boolean = true, cancelable:Boolean = false)
          {
               super( type, bubbles, cancelable )
               m_property = cp;
          }
     }
}