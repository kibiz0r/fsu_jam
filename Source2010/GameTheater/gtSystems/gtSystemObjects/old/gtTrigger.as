//gtState
package GameTheater.gtSystems.gtSystemObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtObjects.*;
	
	public class gtTrigger extends EventDispatcher
	{
		public static const ONCE:int = 0;
		public static const ALWAYS:int = 1;
		
		public static const CUSTOM_EVENT:int = 0;
		
		public static const CLICK:int = 1;
	
		public static const TIMER:int = 4;
		
		public static const STATE_ENTER:int = 5;
		public static const STATE_EXIT:int = 6;
		
		private var m_type = -1;
		private var m_state:String = "none";
		private var m_event_type;
		private var m_obj;
		private var m_sm:gtAdvancedStateMachine;
		private var m_mode:int = ALWAYS;
		
		public function gtTrigger(sm,s,type,obj = null,m = 1)
		{
			//trace("Trigger Created",s,obj);
			m_sm = sm;
			m_sm.addEventListener(gtEvent.CLEAR_TRIGGERS,Listener);
			addEventListener(gtEvent.CHANGE_STATE,m_sm.triggerListener);
			m_state = s;
			m_type = type;
			m_obj = obj;
			m_mode = m;
			
			if (m_type == CLICK)
			{
				m_event_type = MouseEvent.CLICK;
				m_obj.addEventListener(m_event_type,triggerCallback);
			}
			else if (m_type == CUSTOM_EVENT)
			{
				//m_event_type = param1;
			}
			else if (m_type == TIMER)
			{
				if (m_obj)
				{
				}
				else
				{
					m_obj = m_sm;
				}
			}
			else if (m_type == STATE_ENTER)
			{
				m_event_type = gtEvent.STATE_ACTIVATED;
			}
			else if (m_type == STATE_EXIT)
			{
				m_event_type = gtEvent.STATE_DEACTIVATED;
			}
			else
			{
				m_event_type = m_type;
				m_obj.addEventListener(m_event_type,triggerCallback);
			}
			
			
		}
		
		public function triggerCallback(e:Event)
		{
			var evt:gtEvent = new gtEvent(gtEvent.CHANGE_STATE);
			evt.m_state = m_state;
			dispatchEvent(evt);
			if (m_mode == gtTrigger.ONCE)
				CleanUp();
		}
		
		public function Listener(e:gtEvent)
		{
			if (m_sm.GetZone(m_state) == e.m_zone)
			{
				CleanUp();
			}
		}
		
		public function CleanUp()
		{
			//trace("Trigger Destroyed",m_state,m_obj);
			removeEventListener(gtEvent.CHANGE_STATE,m_sm.triggerListener);
			m_sm.removeEventListener(gtEvent.CLEAR_TRIGGERS,Listener);
			m_obj.removeEventListener(m_event_type,triggerCallback);
			m_sm = null;
			m_state = "";
			m_type = -1;
			m_obj = null;
		}
	}
}