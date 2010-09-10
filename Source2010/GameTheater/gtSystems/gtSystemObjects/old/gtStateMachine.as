// gtStateMachine.as 
package GameTheater.gtSystems.gtSystemObjects
{
	public class gtStateMachine
	{
		public var m_currentState;
		public var m_lastState;
		public var m_desiredState;
		
		public var m_introState:Boolean;
		public var m_exitState:Boolean;
		public var m_changeState:Boolean;
		
		public function gtStateMachine(s = null)
		{
			m_currentState = "none";
			m_lastState = "none";
			m_desiredState = "none";
			
			m_exitState = false;
			m_introState = false;
			m_changeState = false;
		
			if (s != null)
			{
				ChangeState(s);
			}
		}
		
		public function CheckState(s):Boolean
		{
			return Boolean(s == m_currentState);
		}
		
		public function Intro():Boolean
		{
			return m_introState;
		}
		
		public function Exit():Boolean
		{
			return m_exitState;
		}
		
		public function ChangeState(s,force:Boolean = false)
		{
			if (s == m_currentState && !force)
				return;
			m_desiredState = s;
			m_changeState = true;
			m_exitState = true;
		}
		
		public function UnChange()
		{
			m_changeState = false;
			m_exitState = false;
		}
		
		public function Update()
		{
			m_introState = false;
			if (m_changeState)
			{
				m_lastState = m_currentState;
				m_currentState = m_desiredState;
				m_introState = true;
				m_changeState = false;
				m_exitState = false;
			}
		}
	}
}