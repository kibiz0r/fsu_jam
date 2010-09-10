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
	
	import flash.geom.*;
	
	public class MotionBehavior3D extends Behavior
	{
		public function MotionBehavior3D()
		{
			m_orderWeight = 0.8;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			o.m_speed = 0;
			o.m_velocity = new Vector3D();
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			o.x += (o.m_velocity.x*(gtTime.deltaT*0.001));
			o.y += (o.m_velocity.y*(gtTime.deltaT*0.001));
			o.z += (o.m_velocity.z*(gtTime.deltaT*0.001));
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}