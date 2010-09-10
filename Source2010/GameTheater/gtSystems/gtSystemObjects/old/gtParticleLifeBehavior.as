//gtParticleLifeBehavior
package GameTheater.gtSystems.gtSystemObjects
{
	import GameTheater.gtTools.*;
	
	public class gtParticleLifeBehavior extends gtParticleBehavior
	{
		public function gtParticleLifeBehavior()
		{
			
		}
		
		public override function Init(e:gtParticleEmitter,p:gtParticle)
		{
			super.Init(e,p);
			p.m_life = gtMathHelper.randRange(1000,2000);
		}
		
		public override function Update(e:gtParticleEmitter,p:gtParticle,deltaT:Number)
		{
			super.Update(e,p,deltaT);
			p.m_life -= deltaT;
			
			if (p.m_life < 0)
				p.m_alive = false;
		}
	}
}