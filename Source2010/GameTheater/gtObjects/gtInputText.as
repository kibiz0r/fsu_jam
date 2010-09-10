//gtButton
package GameTheater.gtObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public dynamic class gtInputText
	{
		public var m_name:String;
		public var m_gameObject:gtGameObject = null;
		public var m_textBox = null;
		
		public var m_edit:Boolean = false;
		public var m_click:Boolean = false;
		//public var m_hover:Boolean = false;
		//public var m_enabled:Boolean = true;
		
		public function gtInputText(n,tb,go)
		{
			m_name = n;
			m_textBox = tb;
			m_gameObject = go;
		}
		
		public function Destroy()
		{
			if (m_edit)
				m_textBox.removeEventListener(Event.CHANGE,ChangeListener);
			if (m_click)
				m_textBox.removeEventListener(MouseEvent.CLICK,ClickListener);
			//if (m_hover)
				//m_button.removeEventListener(MouseEvent.MOUSE_OVER,MouseOverListener);
				//m_button.removeEventListener(MouseEvent.MOUSE_OUT,MouseOutListener);*/
			
			m_textBox = null;
			m_gameObject = null;
		}
		
		// Settings
		public function Edit()
		{
			m_edit = true;
			m_textBox.addEventListener(Event.CHANGE,ChangeListener);
			return this;
		}
		
		public function Click()
		{
			m_click = true;
			m_textBox.addEventListener(MouseEvent.CLICK,ClickListener);
			return this;
		}
		
		public function ChangeListener(e:Event)
		{
			m_gameObject.SendMessage("TextEdit",this);
		}
		
		public function ClickListener(e:MouseEvent)
		{
			m_gameObject.SendMessage("Click",this);
		}
		
		
		
		/*public function Hover()
		{
			m_hover = true;
			m_button.addEventListener(MouseEvent.ROLL_OVER,MouseOverListener);
			m_button.addEventListener(MouseEvent.ROLL_OUT,MouseOutListener);
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
		
		
		
		
		public function MouseOverListener(e:MouseEvent)
		{
			if (m_enabled)
				m_gameObject.SendMessage("MouseOver",this);
		}
		
		public function MouseOutListener(e:MouseEvent)
		{
			if (m_enabled)
				m_gameObject.SendMessage("MouseOut",this);
		}*/
	}
}