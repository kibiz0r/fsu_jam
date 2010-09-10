// gtInput.as 
package GameTheater.gtSystems
{
	import flash.display.*;
	import flash.events.*;
	import GameTheater.gtSystems.gtKey;
	
	public class gtInput extends Sprite
	{
		public static var m_instance = null;
		
		public static var A:Number = 65;
		public static var B:Number = 66;
		public static var C:Number = 67;
		public static var D:Number = 68;
		public static var E:Number = 69;
		public static var F:Number = 70;
		public static var G:Number = 71;
		public static var H:Number = 72;
		public static var I:Number = 73;
		public static var J:Number = 74;
		public static var K:Number = 75;
		public static var L:Number = 76;
		public static var M:Number = 77;
		public static var N:Number = 78;
		public static var O:Number = 79;
		public static var P:Number = 80;
		public static var Q:Number = 81;
		public static var R:Number = 82;
		public static var S:Number = 83;
		public static var T:Number = 84;
		public static var U:Number = 85;
		public static var V:Number = 86;
		public static var W:Number = 87;
		public static var X:Number = 88;
		public static var Y:Number = 89;
		public static var Z:Number = 90;
		
		public var m_keyState:Array;
		public static var m_keys:Array;
		// 0 up
		// 1 down
		// 2 released
		// 3 pressed
		
		public var m_button:Number;
		public var m_mouseWheel:Number;
		public var m_mouseMoved:Boolean;
		
		public function gtInput()
		{
			m_keys = new Array(256);
			for (var i = 0; i < 256; i++)
			{
				m_keys[i] = 0;
			}
			
			m_button = 0;
			m_mouseWheel = 0;
			m_mouseMoved = false;
		}
		
		public static function Init(s:Stage)
		{
			var input = gtInput.GetInstance();
			gtKey.Initialize(s);
			input.addEventListener(MouseEvent.MOUSE_DOWN,input.cbMouseDown);
			input.addEventListener(MouseEvent.MOUSE_UP,input.cbMouseUp);
			input.addEventListener(MouseEvent.MOUSE_WHEEL,input.cbMouseWheel);
			input.addEventListener(MouseEvent.MOUSE_MOVE,input.cbMouseMove);
        	input.addEventListener(MouseEvent.MOUSE_DOWN,input.cbMouseDown,true);
			input.addEventListener(MouseEvent.MOUSE_UP,input.cbMouseUp,true);
			input.addEventListener(MouseEvent.MOUSE_WHEEL,input.cbMouseWheel,true);
			input.addEventListener(MouseEvent.MOUSE_MOVE,input.cbMouseMove,true);
			gtCore.AddEventListener(Event.ENTER_FRAME,input.Update);
		}
				
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new gtInput();
			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}
		
		public function Update(e:Event)
		{
			for (var i = 0; i < 256; i++)
			{
				if (KeyDown(i))
				{
					if (m_keys[i] == 0)
						m_keys[i] = 3;
					else
						m_keys[i] = 1;
				
				}
				if (KeyUp(i))
				{
					if (m_keys[i] == 1)
						m_keys[i] = 2;
					else
						m_keys[i] = 0;
				}
			}
			
			if (m_button == 3)
				m_button = 1;
			if (m_button == 2)
				m_button = 0;
				
			m_mouseWheel = 0;
			m_mouseMoved = false;
		}
		
		// Keyboard
		//-----------------------------	
		public static function KeyUp(key:Number):Boolean
		{
			return (!gtKey.isDown(key));
		}
		
		public static function KeyDown(key:Number):Boolean
		{
			return (gtKey.isDown(key));
		}
		
		public function KeyUp(key:Number):Boolean
		{
			return (!gtKey.isDown(key));
		}
		
		public function KeyDown(key:Number):Boolean
		{
			return (gtKey.isDown(key));
		}
		
		
		public static function KeyReleased(key:Number):Boolean
		{
			return (m_keys[key] == 2);
		}
		
		public static function KeyPressed(key:Number):Boolean
		{
			return (m_keys[key] == 3);
		}
		
		// Mouse
		//-----------------------------
		
		public function cbMouseDown(event:MouseEvent):void
		{
			//trace("mouse down");
			if (m_button == 0)
				m_button = 3;
			else
				m_button = 1;
		}
			
		public function cbMouseUp(event:MouseEvent):void
		{
			//trace("mouse up");
			if (m_button == 1)
				m_button = 2;
			else
				m_button = 0;
		}
		
		public function MouseUp():Boolean
		{
			return (m_button == 0 || m_button == 2);
		}
		
		public function MouseDown():Boolean
		{
			return (m_button == 1 || m_button == 3);
		}
		
		public function MouseReleased():Boolean
		{
			return (m_button == 2);
		}
		
		public function MousePressed():Boolean
		{
			return (m_button == 3);
		}
		
		public function cbMouseMove(event:MouseEvent):void
		{
			m_mouseMoved = true;
		}
		
		public function MouseMove():Boolean
		{
			return m_mouseMoved;
		}
		
		public function cbMouseWheel(event:MouseEvent):void
		{
			m_mouseWheel = event.delta;
		}
		
		public function MouseWheel():Number
		{
			return m_mouseWheel;
		}
	}
}