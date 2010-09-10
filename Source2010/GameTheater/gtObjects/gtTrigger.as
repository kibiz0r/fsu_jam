//gtState
package GameTheater.gtObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtTools.*;
	
	public class gtTrigger extends EventDispatcher
	{
		public static const ONCE:int = 0;
		public static const REPEATING:int = 1;
		
		public var m_object = null;
		public var m_event = null;
		public var m_action:String = "none";
		public var m_parameter = null;
		private var m_type:int = ONCE;
		public var m_gameObject:gtGameObject = null;
		
		public function Repeat()
		{
			m_type = REPEATING;
			return this;
		}
		
		public function gtTrigger(o,e,f,p,go)
		{
			m_gameObject = go;
			m_gameObject.addEventListener(gtEvent.CLEAR_TRIGGERS,Listener);
			m_object = o;
			m_event = e;
			m_action = f;
			m_parameter = p;
			
			m_object.addEventListener(m_event,triggerCallback);
		}
		
		public function triggerCallback(e:Event)
		{
			m_gameObject.SendMessage(m_action,m_parameter==null?e:m_parameter);
			if (m_type == ONCE)
				Destroy();
		}
		
		public function Listener(e:gtEvent)
		{
			Destroy();
		}
		
		public function Destroy()
		{
			m_gameObject.removeEventListener(gtEvent.CLEAR_TRIGGERS,Listener);
			m_object.removeEventListener(m_event,triggerCallback);
			m_event = null;
			m_object = null;
			m_parameter = null;
			m_action = "";
			m_gameObject = null;
		}
	}
}