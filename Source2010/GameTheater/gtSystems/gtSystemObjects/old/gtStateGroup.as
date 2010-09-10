//gtStateGroup
package GameTheater.gtSystems.gtSystemObjects
{
	import GameTheater.gtSystems.gtAdvancedStateMachine;
	import GameTheater.gtSystems.*;
	
	public class gtStateGroup
	{
		public static const MULTI_MODE:int = 0;
		public static const SINGLE_MODE:int = 1;
		
		public var m_name:String = "default";
		
		public var m_mode:int = SINGLE_MODE;
		
		public var m_sm:gtAdvancedStateMachine;
		
		public var m_states:Array;
		
		public var m_currentState:String = "none";
		public var m_lastState:String = "none";
		
		public var m_properties:Array;
		
		public var m_lock:Boolean = false;
		
		public function gtStateGroup()
		{
			m_states = new Array();
			m_properties = new Array();
		}
		
		public function AddProperty(n:String,v = null)
		{
			m_properties[n] = new Object();
			m_properties[n]["default"] = v;
		}
		
		public function SetPropertyValue(n:String,s:String,v)
		{
			if (m_properties[n])
			{
				m_properties[n][s] = v;
			}
			
			if (m_properties[n]["default"] == null)
			{
				m_properties[n]["default"] = v;
			}
		}
		
		public function GetPropertyValue(n:String)
		{
			if (m_properties[n][m_currentState] == null)
			{
				return m_properties[n]["default"];
			}
			else
			{
				return m_properties[n][m_currentState];
			}
		}
		
		public function AddState(n:String,f:Function,l = true,l2 = false)
		{
			//trace(n,"added");
			m_states[n] = new gtState();
			m_states[n].m_stateName = n;
			m_states[n].m_function = f;
			m_states[n].m_looping = l;
			m_states[n].m_looping2 = l2;
			m_states[n].m_sg = this;
		}
		
		public function LoopState(n:String, l:Boolean = true)
		{
			if (m_states[n])
			{
				m_states[n].m_looping = l;
			}
		}
		
		public function LoopState2(n:String, l:Boolean = true)
		{
			if (m_states[n])
			{
				m_states[n].m_looping2 = l;
			}
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
		
		public function ActivateState(s:String)
		{
			if (m_lock)
				return;
			
			if (m_states[s] == null)
			{
				trace("state " + s + " not found");
				return;
			}
			
			if (s != m_currentState)
			{
				m_lastState = m_currentState;
				m_currentState = s;
				
				if (m_mode == SINGLE_MODE)
					DeactivateState(m_currentState,true);
				
				m_states[m_currentState].Activate();
				
				if (m_sm != null && m_sm.m_report)
					trace(s, "activated succesfully");
			}
			else
			{
				m_states[s].Reactivate()
			}
		}
		
		public function DeactivateState(s:String,exclude:Boolean = false)
		{
			if (m_lock)
				return;
				
			if (exclude)
			{
				for (var i:String in m_states)
				{
					if (i != s)
						m_states[i].Deactivate();
				}
			}
			else
			{
				m_lastState = m_currentState;
				m_currentState = "none";
				
				m_states[s].Deactivate();
			}
		}
		
		public function IsOff(s:String)
		{
			if (m_states[s])
			{
				return m_states[s].CheckSetting(gtState.OFF_STATE);
			}
			
			return true;
		}
		
		public function IsNormal(s:String)
		{
			if (m_states[s])
			{
				return m_states[s].CheckSetting(gtState.NORMAL_STATE);
			}
			
			return false;
		}
		
		public function IsEnter(s:String)
		{
			if (m_states[s])
			{
				return m_states[s].CheckSetting(gtState.ENTER_STATE);
			}
			
			return true;
		}
		
		public function IsExit(s:String)
		{
			if (m_states[s])
			{
				return m_states[s].CheckSetting(gtState.EXIT_STATE);
			}
			
			return true;
		}
		
		//--------------------------------------------
		// CLEANUP
		//--------------------------------------------
		public function CleanUp()
		{
			for (var i:String in m_states)
			{
				if (m_states[i] != null)
				{
					m_states[i].CleanUp();
					//m_states[i] = null;
				}
				else
					trace(i,"broke!!!");
				
			}
			
			m_states = null;
			
			m_properties = null;
			
			m_sm = null;
		}
	}
}