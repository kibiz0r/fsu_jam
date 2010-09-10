//gtAnimation
package GameTheater.gtSystems.gtSystemObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public class gtAnimation
	{
		public static const STOP_STATE:int = 0;
		public static const PLAY_STATE:int = 1;
		
		// Animation Message
		public static const ANIMATION_DONE:int = 100;
		public static const TRIGGER_EVENT1:int = 101;
		public static const TRIGGER_EVENT2:int = 102;
		public static const TRIGGER_EVENT3:int = 103;
		public static const ANIMATION_LOOP:int = 104;
		
		public var m_animationName:String;
		
		public var m_ae:gtAnimationEngine = null;	
		
		public var m_setting:int = STOP_STATE;
		
		public function gtState()
		{
		}
		
		public function SendMessage(m)
		{
			if (m_function != null)
					m_function(m);
		}
		
		internal function Play()
		{
			if (m_setting == STOP_STATE)
			{
				m_setting = PLAY_STATE;
			}
		}
		
		public function Reactivate()
		{
			if (m_function != null)
					m_function(REACTIVATE_ATTEMPTED);
		}
		
		internal function Stop()
		{
			if (m_setting == PLAT_STATE)
			{
				m_setting = STOP_STATE;
			}
		}
		
		public function CleanUp()
		{
			
			Stop();
			m_function = null;
			m_sg = null;
		}
	}
}