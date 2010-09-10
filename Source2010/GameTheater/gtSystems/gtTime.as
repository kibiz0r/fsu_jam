// gtTime.as 
package GameTheater.gtSystems
{
	import flash.display.*;
	import flash.events.*;
	import GameTheater.gtSystems.gtSystemObjects.gtTimer;
	
	public class gtTime extends Sprite
	{
		private static var m_instance = null;
		public static var deltaT:Number = 0;
		
		private var m_timer:gtTimer;
		
		public function gtTime(r)
		{
			r.addChild(this);
			m_timer = new gtTimer();
			addEventListener(Event.ENTER_FRAME,Update);
		}
		
		public static function Start(r)
		{
			if(m_instance == null && (r != null))
			{
				m_instance = new gtTime(r);
			}
		}
		
		public static function Stop()
		{
			m_instance.removeEventListener(Event.ENTER_FRAME,m_instance.Update);
			m_instance.parent.removeChild(m_instance);
			m_instance = null;
		}		
		
		public function Update(e:Event)
		{
			m_timer.Update();
			gtTime.deltaT = m_timer.GetElapsedTime();
		}
		
	}
}