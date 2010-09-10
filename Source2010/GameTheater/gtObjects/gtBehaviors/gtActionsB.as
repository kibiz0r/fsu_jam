// gtBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import flash.events.Event;
	
	public dynamic class gtActionsB extends gtBehavior
	{
		private var m_actions:Vector.<gtAction> = new Vector.<gtAction>();
		private var m_perform:Boolean = false;
		
		public function gtActionsB()
		{
			m_name = "actions";
			m_orderWeight = -0.7;
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
			
		}
		
		public function Clear()
		{
			for (var i:uint = 0; i < m_actions.length; i++)
			{
				m_actions[i].Destroy();
				m_actions[i] = null;
			}
			m_actions = new Vector.<gtAction>()
			m_perform = false;
		}
		
		public override function Destructor()
		{
			for (var i:uint = 0; i < m_actions.length; i++)
			{
				m_actions[i].Destroy();
				m_actions[i] = null;
			}
			m_actions = new Vector.<gtAction>()
			m_perform = false;
			
			super.Destructor();
		}
		
		public function UpdateWeights()
		{
			m_actions = m_actions.sort(Sort);
		}
		
		public function Sort(a:gtAction,b:gtAction)
		{
			if (a.m_weight > b.m_weight)
				return -1;
			else if (a.m_weight < b.m_weight)
				return 1;
			else if (a.m_weight == b.m_weight)
				return 0;
		}
		
		public function Perform(a:String,p = null)
		{
			var action = new gtAction(a,p,gameObject);
			m_actions.push(action);
			UpdateWeights();
			if (!m_perform)
			{
				m_perform = true;
				//gtCore.InvalidateDisplay();
				gtCore.AddEventListener(Event.ENTER_FRAME,PerformActions,-1);
			}
			return action;
		}
		
		public function PerformActions(e:Event)
		{
			var queued:Boolean = false;
			var actions = m_actions;
			m_actions = new Vector.<gtAction>();
			for (var i:uint = 0; i < actions.length; i++)
			{
				if (actions[i].m_type == gtAction.INSTANT)
				{
					actions[i].Perform();
					actions[i].Destroy();
					actions[i] = null;
				}
				else if (actions[i].m_type == gtAction.QUEUED)
				{
					if (queued)
						m_actions.push(actions[i]);
					else
					{
						queued = true;
						actions[i].Perform();
						actions[i].Destroy();
						actions[i] = null;
					}
				}
				else if (actions[i].m_type == gtAction.DELAYED)
				{
					if (actions[i].m_value <= 0)
					{
						actions[i].Perform();
						actions[i].Destroy();
						actions[i] = null;
					}
					else
					{
						actions[i].m_value -= gtTime.deltaT;
						m_actions.push(actions[i]);
					}
				}
				else if (actions[i].m_type == gtAction.REPEATING)
				{
					if (actions[i].m_value <= 0)
					{
						actions[i].Perform();
						actions[i].m_value = actions[i].m_valueTotal;
						m_actions.push(actions[i]);
						actions[i] = null;
					}
					else
					{
						actions[i].m_value -= gtTime.deltaT;
						m_actions.push(actions[i]);
					}
				}
			}
			
			if (m_actions.length == 0)
			{
				m_perform = false;
				gtCore.RemoveEventListener(Event.ENTER_FRAME,PerformActions);
			}
			else
			{
				//gtCore.InvalidateDisplay();
				UpdateWeights();
			}
		}
	}
}