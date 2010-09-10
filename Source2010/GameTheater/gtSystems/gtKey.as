// psKey.as
package GameTheater.gtSystems
{
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
   
    public class gtKey {
       
        private static var m_initialized:Boolean = false;
        private static var m_keysDown:Object = new Object();
       
        public static function Initialize(s:Stage) 
		{
            if (!m_initialized && s != null) 
			{
               	//s.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
                //s.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
				
				s.addEventListener( KeyboardEvent.KEY_DOWN, keyPressed, false, 0, true );
				s.addEventListener( KeyboardEvent.KEY_UP, keyReleased, false, 0, true );
				s.addEventListener( Event.ACTIVATE, clearKeys, false, 0, true );
				s.addEventListener( Event.DEACTIVATE, clearKeys, false, 0, true );
                m_initialized = true;
            }
        }
       
        public static function isDown(keyCode:uint):Boolean 
		{
            if (!m_initialized || m_keysDown[keyCode] == undefined) 
			{
               return false;
            }
            return Boolean(m_keysDown[keyCode]);
        }
       
        private static function keyPressed(event:KeyboardEvent):void 
		{
			//trace("key pressed:"+event.keyCode);
            m_keysDown[event.keyCode] = true;
        }
       
        private static function keyReleased(event:KeyboardEvent):void 
		{
			//trace("key released:"+event.keyCode);
            if (m_keysDown[event.keyCode]) {
                m_keysDown[event.keyCode] = false;
            }
        }
       
        private static function clearKeys(event:Event):void 
		{
            m_keysDown = new Object();
        }
    }
}