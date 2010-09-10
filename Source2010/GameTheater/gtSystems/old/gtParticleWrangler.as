//gtParticleWrangler
package GameTheater.gtSystems
{	
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*
	
	public class gtParticleWrangler
	{
		public static var m_instance = null;
		
		public var m_effects:Array;
		public var m_emitters:Array;
		public var m_deadParticles:Array;
		
		public function gtParticleWrangler()
		{
			m_emitters = new Array();
			m_effects = new Array();
			m_deadParticles = new Array();
		}
		
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new gtParticleWrangler;

			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}		
		
		public function Spawn(effect:String):gtParticleEmitter
		{
			//trace("dead: " + m_deadParticles.length);
			var newEmitter:gtParticleEmitter = new gtParticleEmitter();
			return newEmitter;
		}
		
		public function NewParticle():gtParticle
		{
			var newParticle:gtParticle;
			if (m_deadParticles.length > 0)
				newParticle = m_deadParticles.pop();
			else
				newParticle = new gtParticle();
			
			return newParticle;
		}
		
		public function ReleaseParticle(p:gtParticle)
		{
			m_deadParticles.push(p);
		}
	}
}