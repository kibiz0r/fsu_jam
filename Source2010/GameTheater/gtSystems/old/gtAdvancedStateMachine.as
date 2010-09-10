// gtAdvancedStateMachine.as 
package GameTheater.gtSystems
{
	import flash.events.*;
	import flash.display.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	
	public class gtAdvancedStateMachine extends MovieClip
	{
		
		public var m_stateGroups:Array = new Array();
		public var m_stateGroupsIndex:Array = new Array();
		public var m_propertyGroupsIndex:Array = new Array();
		public var m_triggers:Array = new Array();
		
		public var m_report:Boolean = false;
		
		public function gtAdvancedStateMachine()
		{
			
		}
		
		//--------------------------------------------
		// TRIGGERS
		//--------------------------------------------
		
		public function triggerListener(e:gtEvent)
		{
			//trace("triggering state:",e.m_state);
			ActivateState(e.m_state);
		}
		
		public function AddTrigger(o,t,s,m = 1)
		{
			new gtTrigger(this,s,t,o,m);
		}
		
		public function ClearTriggers(zone = "main")
		{
			var evt:gtEvent = new gtEvent(gtEvent.CLEAR_TRIGGERS);
			evt.m_zone = zone;
			dispatchEvent(evt);
		}
		
		//--------------------------------------------
		// PROPERTIES
		//--------------------------------------------
		
		public function SetPropertyValue(n:String,s:String,v)
		{
			if (m_propertyGroupsIndex[n])
			{
				GetStateGroup(m_propertyGroupsIndex[n]).SetPropertyValue(n,s,v);
			}
			else
			{
				m_propertyGroupsIndex[n] = m_stateGroupsIndex[s];
				var group = GetStateGroup(m_propertyGroupsIndex[n]);
				group.AddProperty(n,v);
				group.SetPropertyValue(n,s,v);
			}
		}
		
		public function GetPropertyValue(n:String)
		{
			if (m_propertyGroupsIndex[n])
			{
				return GetStateGroup(m_propertyGroupsIndex[n]).GetPropertyValue(n);
			}
			
			return null;
		}
		
		//--------------------------------------------
		// STATES
		//--------------------------------------------
		public function NewStateGroup(g:String,m:int = 0)
		{
			var group = GetStateGroup(g);
			group.m_mode = m;
		}
		
		public function NewState(n:String,f:Function,g:String = "main")
		{
			var group = GetStateGroup(g);
			m_stateGroupsIndex[n] = g;
			return group.AddState(n,f);
		}
		
		public function NewStaticState(n:String,f:Function,g:String = "main")
		{
			var group = GetStateGroup(g);
			m_stateGroupsIndex[n] = g;
			return group.AddState(n,f,false,false);
		}
		
		public function RequestAnimationMessage(anim_mc,n:String,m:int)
		{
			var group = GetStateGroup(m_stateGroupsIndex[n]);
			//return group.AddState(n,f,false,false);
		}
		
		public function LoopState(n:String, l:Boolean = true)
		{
			if (m_stateGroupsIndex[n])
			{
				m_stateGroups[m_stateGroupsIndex[n]].LoopState(n,l);
			}
		}
		
		public function LoopState2(n:String, l:Boolean = true)
		{
			if (m_stateGroupsIndex[n])
			{
				m_stateGroups[m_stateGroupsIndex[n]].LoopState2(n,l);
			}
		}
		
		public function GetZone(n:String):String
		{
			return m_stateGroupsIndex[n];
		}
		
		public function GetStateGroup(g:String)
		{
			if (m_stateGroups[g])
			{
				return m_stateGroups[g];
			}
			else
			{
				m_stateGroups[g] = new gtStateGroup();
				m_stateGroups[g].m_name = g;
				m_stateGroups[g].m_sm = this;
				return m_stateGroups[g];
			}
		}
		
		public function Lock(s = null)
		{
			if (s == null)
			{
				for (var i:String in m_stateGroups)
				{
					if (m_stateGroups[i] != null)
					{
						m_stateGroups[i].m_lock = true;
					}
				}
			}
			else
			{
				GetStateGroup(s).m_lock = true;
			}
		}
		
		public function Unlock(s = null)
		{
			if (s == null)
			{
				for (var i:String in m_stateGroups)
				{
					if (m_stateGroups[i] != null)
					{
						m_stateGroups[i].m_lock = false;
					}
				}
			}
			else
			{
				GetStateGroup(s).m_lock = false;
			}
		}
		
		public function CheckState(n:String)
		{
			if (m_stateGroupsIndex[n])
			{
				return !GetStateGroup(m_stateGroupsIndex[n]).IsOff(n);
			}
			
			return false;
		}
		
		public function LastState(g:String = "main")
		{
			GetStateGroup(g).LastState();
		}
		
		public function ActivateState(n:String)
		{
			GetStateGroup(m_stateGroupsIndex[n]).ActivateState(n);
		}
		
		public function DeactivateState(n:String)
		{
			GetStateGroup(m_stateGroupsIndex[n]).DeactivateState(n);
		}
		
		//--------------------------------------------
		// CLEANUP
		//--------------------------------------------
		public function CleanUp()
		{
			for (var i:String in m_stateGroups)
			{
				if (m_stateGroups[i] != null)
				{
					ClearTriggers(i);
					m_stateGroups[i].CleanUp();
					//m_stateGroups[i] = null;
					//trace(i,"StateGroup CleanedUp");
				}
				else
					trace(i,"broke");
			}
			m_stateGroups = null;
			
			
			m_stateGroupsIndex = null;
			m_propertyGroupsIndex = null;
			m_triggers = null;
		
		}
	}
}