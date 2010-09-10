// gtCore.as 
package GameTheater.gtSystems
{
	import flash.display.*;
	import flash.events.*;
	import GameTheater.gtSystems.gtSystemObjects.gtTimer;
	import PinStriper.psSystems.psEasel;
	
	public class gtCore extends MovieClip
	{
		private static var m_instance = null;
		
		public static function Setup()
		{
			if(m_instance == null)
			{
				new gtCore();
			}
		}
		
		public function gtCore()
		{
			m_instance = this;
			addEventListener(Event.ADDED_TO_STAGE,AttachedListener);
			main.that.addChild(this);
			gtTime.Start(m_instance);
		}
		
		public function AttachedListener(e:Event)
		{
			gtInput.Init(m_instance.stage);
			
			m_instance.removeEventListener(Event.ADDED_TO_STAGE,AttachedListener);
		}
		
		public static function DispatchMessage(m)
		{
			m_instance.dispatchEvent(m);
		}
		
		public static function InvalidateDisplay()
		{
			if (psEasel.that != null && psEasel.that.stage != null)
				psEasel.that.stage.invalidate();		
		}
		
		public static function AddEventListener(e,l,p = 0)
		{
			m_instance.addEventListener(e,l,false,p);
		}
		
		public static function AddMessageListener(e,l)
		{
			m_instance.addEventListener(e,l);
		}
		
		public static function RemoveEventListener(e,l)
		{
			m_instance.removeEventListener(e,l);
		}
		
		public static function RemoveMessageListener(e,l)
		{
			m_instance.removeEventListener(e,l);
		}
		
		public static function Stop()
		{
			m_instance.parent.removeChild(m_instance);
			m_instance = null;
		}
	}
}