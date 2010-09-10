//gtState
package GameTheater.gtSystems.gtSystemObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public class gtState
	{
		public static const OFF_STATE:int = 0;
		public static const INIT_STATE:int = 1;
		public static const ENTER_STATE:int = 2;
		public static const NORMAL_STATE:int = 3;
		public static const LOOPING_STATE:int = 3;
		public static const NORMAL2_STATE:int = 4;
		public static const LOOPING2_STATE:int = 4;
		public static const EXIT_STATE:int = 5;
		public static const ON_STATE:int = 6;
		
		// Messages
		public static const REACTIVATE_ATTEMPTED:int = 50;
		
		// Animation Message
		public static const ANIMATION_DONE:int = 100;
		public static const TRIGGER_EVENT1:int = 101;
		public static const TRIGGER_EVENT2:int = 102;
		public static const TRIGGER_EVENT3:int = 103;
		public static const ANIMATION_LOOP:int = 104;
		
		public var m_looping:Boolean = true;
		public var m_looping2:Boolean = false;
		
		public var m_stateName:String;
		
		public var m_sg:gtStateGroup = null;	
		
		public var m_setting:int = OFF_STATE;
		
		public var m_function:Function = null;
		
		public function gtState()
		{
		}
		
		internal function Activate()
		{
			if (m_setting == OFF_STATE)
			{
				if (m_looping)
				{
					gtCore.AddEventListener(Event.ENTER_FRAME,Update);
					m_setting = ENTER_STATE;
				}
				else
				{
					m_setting = ON_STATE;
				}
				
				if (m_looping2)
				{
					gtCore.AddEventListener(Event.RENDER,Update2);
				}
				
				if (m_function != null)
					m_function(INIT_STATE);
			}
		}
		
		public function Reactivate()
		{
			if (m_function != null)
					m_function(REACTIVATE_ATTEMPTED);
		}
		
		public function SendMessage(m)
		{
			if (m_function != null)
					m_function(m);
		}
		
		internal function Deactivate()
		{
			if (m_setting == OFF_STATE)
				return;
				
			if (m_function != null)
				m_function(EXIT_STATE);
			
			m_setting = OFF_STATE;
				
			if (m_looping)
				gtCore.RemoveEventListener(Event.ENTER_FRAME,Update);
				
			if (m_looping2)
			{
				gtCore.RemoveEventListener(Event.RENDER,Update2);		
			}
		}
		
		internal function CheckSetting(s:int):Boolean
		{
			if (m_setting == s)
				return true;
				
			return false;
		}
		
		public function Update(e:Event)
		{
			if (m_function != null)
			{
				m_function(m_setting);
			}
			
			if (m_setting == ENTER_STATE)
			{
				m_setting = NORMAL_STATE;
				// maybe add setting for this
				m_function(m_setting);
			}
			
			psEasel.m_stage.invalidate();
		}
		
		public function Update2(e:Event)
		{
			if (m_function != null && m_setting == NORMAL_STATE)
			{
				m_function(NORMAL2_STATE);
			}
		}
		
		public function CleanUp()
		{
			Deactivate();
			m_function = null;
			m_sg = null;
		}
	}
}