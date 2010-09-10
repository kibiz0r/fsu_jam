//gtParticle
package GameTheater.gtSystems.gtSystemObjects
{
	import flash.display.*;
	
	public dynamic class gtParticle extends MovieClip
	{
		public var m_alive:Boolean = true;
		
		public function gtParticle()
		{
			cacheAsBitmap = true;
			scaleX = 1;
			scaleY = 1;
			alpha = 0.2;
		}
		
		public function Update(deltaT:Number)
		{

		}
	}
}