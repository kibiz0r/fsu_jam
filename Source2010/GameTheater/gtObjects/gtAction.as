//gtAction.as 
package GameTheater.gtObjects
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class gtAction
	{
		public static const INSTANT:int = 0;
		public static const QUEUED:int = 1;
		public static const DELAYED:int = 2;
		public static const REPEATING:int = 3;
		
		public var m_weight:Number = 0;
		public var m_action:String = "none";
		public var m_parameter;
		public var m_type:int = INSTANT;
		public var m_value:Number = 0;
		public var m_valueTotal:Number = 0;
		public var m_gameObject:gtGameObject = null;
		
		public function Weight(w)
		{
			m_weight = w;
			m_gameObject.actions.UpdateWeights();
			return this;
		}
		
		public function Queue()
		{
			m_type = QUEUED;
			m_value = 0;
			return this;
		}
		
		public function Delay(ms:Number)
		{
			m_type = DELAYED;
			m_value = ms;
			return this;
		}
		
		public function Repeat(ms:Number = 0)
		{
			m_type = REPEATING;
			m_value = 0;
			m_valueTotal = ms;
			return this;
		}
		
		public function gtAction(action,p,go)
		{
			m_action = action;
			m_parameter = p;
			m_type = 1;
			m_gameObject = go;
		}
		
		public function Perform()
		{
			m_gameObject.SendMessage(m_action,m_parameter);
		}
		
		public function Destroy()
		{
			m_action = "";
			m_parameter = 0;
			m_type = -1;
			m_value = 0;
			m_valueTotal = 0;
			m_gameObject = null;
		}
	}
}