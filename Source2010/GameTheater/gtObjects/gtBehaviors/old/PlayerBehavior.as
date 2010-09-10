// PlayerBehavior.as 
package GameTheater
{
	import GameTheater.*;
	import PinStriper.psTools.*;
	
	public class PlayerBehavior extends Behavior
	{
		public function PlayerBehavior()
		{
			
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			o.AddBehavior(MotionBehavior);
			o.AddBehavior(InputBehavior);
			o.AddBehavior(WrapScreenBehavior);
			o.AddBehavior(MountBehavior);
			o.m_direction.x = 0;
			o.m_direction.y = -1;
			o.m_velocity.x = 0;
			o.m_velocity.y = 0;
			o.m_speed = 400;
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}