//gtAction.as 
package GameTheater.gtObjects.gtActions
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
		public var m_name:String;
		public var m_weight:Number = 0;
		public var m_action:String = "none";
		public var m_type:int = 0;
		
		public static const ACTION_FUNCTION:int = 0;
		public static const ACTION_ACTIVATE_STATE:int = 1;
		
		public function gtAction()
		{
			m_name = "none"
		}
		
		public function Destroy(o:Object)
		{
		}
	}
}