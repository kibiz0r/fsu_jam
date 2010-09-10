//gtParticleMotionBehavior
package GameTheater.gtSystems.gtSystemObjects
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class gtParticleMotionBehavior extends gtParticleBehavior
	{
		public function gtParticleMotionBehavior()
		{
			
		}
		
		public override function Init(e:gtParticleEmitter,p:gtParticle)
		{
			super.Init(e,p);
			p.m_speed = 10;
			p.m_rotation = gtMathHelper.randRange(0,360);
			p.m_rotVel = 0;
			p.m_velocity = new psVec2();
			p.m_direction = new psVec2();
			
			p.m_speed = gtMathHelper.randRange(5,20);
			
			p.m_rotVel = gtMathHelper.randRange(0,360)-180;
			
			p.m_direction.x = gtMathHelper.randRange(0,500);
			p.m_direction.y = gtMathHelper.randRange(0,500);
			
			if (gtMathHelper.randRange(0,100)<50)
				p.m_direction.x *= -1;
				
			if (gtMathHelper.randRange(0,100)<50)
				p.m_direction.y *= -1;
			
			p.m_direction.normalize();
			
			p.m_velocity.x = p.m_direction.x * p.m_speed;
			p.m_velocity.y = p.m_direction.y * p.m_speed;
		}
		
		public override function Update(e:gtParticleEmitter,p:gtParticle,deltaT:Number)
		{
			super.Update(e,p,deltaT);
			/*if (p.m_rotVel != 0)
			{
				if (p.m_rotVel > -1 && p.m_rotVel < 1)
					p.m_rotVel = 0;
				else
				{
					p.m_rotation += (p.m_rotVel*(deltaT*0.001));
					p.m_direction.x = Math.cos((p.m_rotation-90)*(Math.PI/180));
					p.m_direction.y = Math.sin((p.m_rotation-90)*(Math.PI/180));
				}
			}
			p.rotation = p.m_rotation;*/
			p.x += (p.m_velocity.x*(deltaT*0.001));
			p.y += (p.m_velocity.y*(deltaT*0.001));
		}
	}
}