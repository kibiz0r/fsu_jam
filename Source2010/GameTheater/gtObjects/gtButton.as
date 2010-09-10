//gtButton
package GameTheater.gtObjects
{
	import flash.events.*;
	import flash.ui.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public dynamic class gtButton
	{
		public var m_name:String;
		public var m_gameObject:gtGameObject = null;
		public var m_button = null;
		
		public var m_click:Boolean = false;
		public var m_mouse:Boolean = false;
		public var m_hover:Boolean = false;
		public var m_hand:Boolean = false;
		public var m_enabled:Boolean = true;
		public var m_over:Boolean = false;
		
		public function gtButton(n,b,go)
		{
			m_name = n;
			m_button = b;
			m_gameObject = go;
		}
		
		public function Destroy()
		{
			Enable(true);
			if (m_click)
				m_button.removeEventListener(MouseEvent.CLICK,ClickListener);
			if (m_hover)
				m_button.removeEventListener(MouseEvent.MOUSE_OVER,MouseOverListener);
				m_button.removeEventListener(MouseEvent.MOUSE_OUT,MouseOutListener);
			if (m_mouse)
				psEasel.that.stage.removeEventListener(MouseEvent.MOUSE_DOWN,MouseDown);
				psEasel.that.stage.removeEventListener(MouseEvent.MOUSE_UP,MouseUp);
			
			if (m_hand && m_over)
				Mouse.cursor = MouseCursor.AUTO;
			m_hand = false;
			m_over = false;
			
			m_button = null;
			m_gameObject = null;
		}
		
		// Settings
		public function Click()
		{
			m_click = true;
			m_button.addEventListener(MouseEvent.CLICK,ClickListener);
			return this;
		}
		
		public function Hover(hand:Boolean = false)
		{
			m_hover = true;
			m_hand = hand;
			m_button.addEventListener(MouseEvent.ROLL_OVER,MouseOverListener);
			m_button.addEventListener(MouseEvent.ROLL_OUT,MouseOutListener);
			return this;
		}
		
		public function MouseState()
		{
			m_mouse = true;
			psEasel.that.stage.addEventListener(MouseEvent.MOUSE_DOWN,MouseDown);
			psEasel.that.stage.addEventListener(MouseEvent.MOUSE_UP,MouseUp);
			return this;
		}
		
		public function Enable(s:Boolean = true)
		{
			m_enabled = s;
			if (m_enabled)
			{
				m_button.alpha = 1;
				m_button.mouseEnabled = true;
			}
			else
			{
				m_button.alpha = 0.25;
				m_button.mouseEnabled = false;
			}
		}
		
		
		public function ClickListener(e:MouseEvent)
		{
			if (m_enabled && m_gameObject != null)
				m_gameObject.SendMessage("Click",this);
		}
		
		public function MouseOverListener(e:MouseEvent)
		{
			m_over = true;
			if (m_hand)
				Mouse.cursor = MouseCursor.BUTTON;
			
			if (m_enabled && m_gameObject != null)
				m_gameObject.SendMessage("MouseOver",this);
		}
		
		public function MouseOutListener(e:MouseEvent)
		{
			if (m_hand && m_over)
				Mouse.cursor = MouseCursor.AUTO;
				
			m_over = false;
			
			if (m_enabled && m_gameObject != null)
				m_gameObject.SendMessage("MouseOut",this);
		}
		
		public function MouseDown(e:MouseEvent)
		{
			if (m_enabled && m_gameObject != null && m_over)
				m_gameObject.SendMessage("MouseDown",this);
		}
		
		public function MouseUp(e:MouseEvent)
		{
			if (m_enabled && m_gameObject != null && m_over)
				m_gameObject.SendMessage("MouseUp",this);
		}
	}
}