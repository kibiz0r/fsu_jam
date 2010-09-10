// ProjectileBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	
	public class ProjectileBehavior extends Behavior
	{
		public var m_gravity = 98;
		
		public function ProjectileBehavior()
		{
			m_orderWeight = 0.8;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			o.m_rotation = 0;
			o.rotVelocity = 0;
			o.m_velocity = new psVec2();
			o.m_rotate = false;
			o.m_pause = false;
			o.m_gravity = true;
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			
			if (! o.m_pause)
			{
				o.m_rotation += (o.rotVelocity * (gtTime.deltaT*0.001));
				
				if (o.m_rotate)
				{
					o.m_rotation = Math.atan(o.m_velocity.y/o.m_velocity.x);
					
					o.m_rotation *= (180/Math.PI);
					
					o.m_rotation -= 90;
					
					if (o.m_velocity.x > 0)
						o.m_rotation += 180;
				}
				
				o.rotation = o.m_rotation; 
				
				if (o.m_gravity)
					o.m_velocity.y += m_gravity * (gtTime.deltaT*0.001);
				
				o.x += (o.m_velocity.x*(gtTime.deltaT*0.001));
				o.y += (o.m_velocity.y*(gtTime.deltaT*0.001));
			}
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}