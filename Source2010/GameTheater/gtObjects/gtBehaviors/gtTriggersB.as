// gtTriggersB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtTools.*;
	import flash.events.Event;
	
	public dynamic class gtTriggersB extends gtBehavior
	{
		public function gtTriggersB()
		{
			m_name = "triggers";
			m_orderWeight = -0.7;
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
			
		}
		
		public override function Destructor()
		{
			gameObject.dispatchEvent(new gtEvent(gtEvent.CLEAR_TRIGGERS));
			super.Destructor();
		}
		
		public function Add(o,e,f:String,p = null)
		{
			var t = new gtTrigger(o,e,f,p,gameObject);
			return t;
		}
	}
}