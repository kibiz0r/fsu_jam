//gtState
package GameTheater.gtObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public dynamic class gtState extends gtObject
	{
		public static var m_count:int = 0;
		
		// old stuff
		public static const OFF_STATE:int = 0;
		public static const INIT_STATE:int = 1;
		public static const ENTER_STATE:int = 2;
		public static const NORMAL_STATE:int = 3;
		public static const NORMAL2_STATE:int = 4;
		public static const EXIT_STATE:int = 5;
		public static const ON_STATE:int = 6;
		
		// Messages
		public static const REACTIVATE_ATTEMPTED:int = 50;
		
		// new stuff
		public static const OFF:int = 0;
		public static const INIT:int = 1;
		public static const ENTER:int = 2;
		public static const UPDATE:int = 3;
		public static const LATE_UPDATE:int = 4;
		public static const EXIT:int = 5;
		public static const ON:int = 6;
		public static const REACTIVATE:int = 50;
		
		// Animation Message
		public static const ANIMATION_DONE:int = 100;
		public static const TRIGGER_EVENT1:int = 101;
		public static const TRIGGER_EVENT2:int = 102;
		public static const TRIGGER_EVENT3:int = 103;
		public static const ANIMATION_LOOP:int = 104;
		
		public var m_enter:Boolean = false;
		public var m_update:Boolean = false;
		public var m_lateUpdate:Boolean = false;
		public var m_sendMessage:Boolean = false;
		
		public var m_name:String;
		
		public var m_setting:int = OFF;
		
		public var m_function:Function = null;
		public var m_gameObject:gtGameObject = null;
		
		public function gtState(n,f,go)
		{
			m_name = n;
			m_function = f;
			m_gameObject = go;
		}
		
		public function Enter()
		{
			m_enter = true;
			return this;
		}
		
		public function Update()
		{
			m_update = true;
			m_enter = true;
			return this;
		}
		
		public function LateUpdate()
		{
			m_lateUpdate = true;
			m_enter = true;
			return this;
		}
		
		public function SendMessage()
		{
			m_sendMessage = true;
			return this;
		}
		
		public function Activate()
		{
			if (m_setting == OFF)
			{
				if (m_update || m_enter)
				{
					gtCore.AddEventListener(Event.ENTER_FRAME,Update1);
					m_count++;
					//trace("Update Loop: " + m_name);
					m_setting = ENTER;
				}
				else
				{
					m_setting = ON;
				}
				
				if (m_lateUpdate)
				{
					gtCore.AddEventListener(Event.RENDER,Update2);
				}
				
				
				Call(INIT);
			}
		}
		
		public function Reactivate()
		{
			Call(REACTIVATE);
		}
		
		public function Call(setting)
		{
			if (m_function != null)
			{
				if (m_sendMessage && m_gameObject != null)
					m_gameObject.SendMessage(m_name,setting);
				else
					m_function(setting);
			}
		}
		
		public function Deactivate()
		{
			if (m_setting == OFF)
				return false;
			
			
			Call(EXIT);
			
			m_setting = OFF;
				
			if (m_update)
			{
				gtCore.RemoveEventListener(Event.ENTER_FRAME,Update1);
				m_count--;
			}
			
			if (m_lateUpdate)
			{
				gtCore.RemoveEventListener(Event.RENDER,Update2);		
			}
			return true;
		}
		
		public function Update1(e:Event)
		{
			Call(m_setting);
					
			if (m_setting == ENTER)
			{
				// calls normal on enter as well
				if (m_update)
				{
					m_setting = UPDATE;
					Call(m_setting);
				}
				else
				{
					gtCore.RemoveEventListener(Event.ENTER_FRAME,Update1);
					m_count--;
					m_setting = ON;
				}
			}
			
			gtCore.InvalidateDisplay();
		}
		
		public function Update2(e:Event)
		{
			if (m_setting == UPDATE)
			{
				Call(LATE_UPDATE);
			}
		}
		
		public override function Destructor()
		{
			Deactivate();
			m_function = null;
			m_gameObject = null;
			m_enter = false;
			m_update = false;
			m_lateUpdate = false;
			m_sendMessage = false;
			super.Destructor();
		}
	}
}