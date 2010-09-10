// gtTimer.as 
package GameTheater.gtSystems.gtSystemObjects
{
	import flash.utils.getTimer;
	
	public class gtTimer
	{
		private var m_lastTimer:Number;
		private var m_elapsedTime:Number;
		
		public function gtTimer()
		{
			Reset();
		}
		
		public function Reset()
		{
			m_lastTimer = getTimer();
			m_elapsedTime = 0;
		}
		
		public function Update()
		{
			m_elapsedTime = getTimer() - m_lastTimer;
			m_lastTimer = getTimer();
		}
		
		public function GetElapsedTime():Number
		{
			return m_elapsedTime;
		}
		
		public function GetCurrentElapsedTime():Number
		{
			return (getTimer() - m_lastTimer);
		}
	}
}