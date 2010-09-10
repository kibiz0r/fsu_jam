// MotionBehavior.as 
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
	
	
	public class MotionBehavior extends Behavior
	{
		public function MotionBehavior()
		{
			m_orderWeight = 0.8;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			o.m_speed = 0;
			o.m_rotation = 0;
			o.m_rotVel = 0;
			o.m_velocity = new psVec2();
			o.m_direction = new psVec2();
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			if (o.m_rotVel != 0)
			{
				if (o.m_rotVel > -1 && o.m_rotVel < 1)
					o.m_rotVel = 0;
				else
				{
					o.m_rotation += (o.m_rotVel*(gtTime.deltaT*0.001));
					o.m_direction.x = Math.cos((o.m_rotation-90)*(Math.PI/180));
					o.m_direction.y = Math.sin((o.m_rotation-90)*(Math.PI/180));
				}
			}
			o.rotation = o.m_rotation;
			o.m_direction.normalize();
			o.x += (o.m_velocity.x*(gtTime.deltaT*0.001));
			o.y += (o.m_velocity.y*(gtTime.deltaT*0.001));
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}