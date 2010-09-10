//gtAnimtaionEngine
package GameTheater.gtSystems
{
	import GameTheater.gtSystems.gtAdvancedStateMachine;
	import GameTheater.gtSystems.*;
	
	public class gtAnimtaionEngine
	{
		public var m_name:String = "default";
		
		public var m_mc;
		
		public var m_animtaions:Array;
		
		public var m_currentAnimtaion:String = "none";
		public var m_lastAnimation:String = "none";
		
		public function gtAnimtaionEngine()
		{
			m_states = new Array();
			m_properties = new Array();
		}
		
		public function AddController(mc)
		{
			m_mc = mc;
		}
		
		public function AddAnimation(n:String)
		{
			//trace(n,"added");
			m_animtaions[n] = new gtAnimation();
			m_animtaions[n].m_stateName = n;
			m_animtaions[n].m_function = f;
			m_animtaions[n].m_looping = l;
			m_animtaions[n].m_looping2 = l2;
			m_animtaions[n].m_sg = this;
		}
		
		public function LastState()
		{
			if (m_lastState == "none")
			{
				return;
			}
			else
			{
				ActivateState(m_lastState);
			}
		}
		
		public function PlayAnimtion(a:String)
		{
			if (m_animtaions[s] == null)
			{
				trace("animtaion " + a + " not found");
				return;
			}
			
			if (a != m_currentAnimtaion)
			{
				m_lastAnimation = m_currentAnimtaion;
				m_currentAnimtaion = a;
				
				if (m_lastAnimation != "none")
					m_animtaions[m_lastAnimation].Stop();
				m_animtaions[m_currentAnimtaion].Play();
			}
		}
		
		//--------------------------------------------
		// CLEANUP
		//--------------------------------------------
		public function CleanUp()
		{
			for (var i:String in m_animtaions)
			{
				if (m_animtaions[i] != null)
				{
					m_animtaions[i].CleanUp();
					//m_states[i] = null;
				}
				else
					trace(i,"broke!!!");
				
			}
			
			m_animtaions = null;
			
			m_mc = null;
		}
	}
}