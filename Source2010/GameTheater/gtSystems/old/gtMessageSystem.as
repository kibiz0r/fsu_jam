//gtMessageSystem
package GameTheater.gtSystems
{
	import flash.display.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class gtMessageSystem extends Sprite
	{
		public static var m_instance = null;
		
		public function gtMessageSystem()
		{
			 MovieClip(psEasel.m_root.content).addChild(this);
		}
		
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new gtMessageSystem;

			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}
		
		public function Dispatch(m:gtMessage)
		{
			dispatchEvent( new gtMessage( gtMessage.GAME_MESSAGE, "myProp", true) );
		}
	}
}