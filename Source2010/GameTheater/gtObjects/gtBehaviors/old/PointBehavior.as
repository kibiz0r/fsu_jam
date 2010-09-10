// PointBehavior.as 
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
	
	public class PointBehavior extends Behavior
	{
		public function PointBehavior()
		{
			m_orderWeight = 0;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			
			
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			
			if (!o.m_alive)
			{
				for (var i = 0; i < 10; i++)
				{
					var newPB:PointBall = new PointBall();
					newPB.x = o.x;
					newPB.y = o.y;
					
					newPB.m_speed = psMathHelper.randRange(200,800);
					
					newPB.m_direction.x = psMathHelper.randRange(0,800);
					newPB.m_direction.y = psMathHelper.randRange(0,600);
					
					if (psMathHelper.randRange(0,100)<50)
						newPB.m_direction.x *= -1;
						
					if (psMathHelper.randRange(0,100)<50)
						newPB.m_direction.y *= -1;
					
					newPB.m_direction.normalize();
					
					newPB.m_velocity.x = newPB.m_direction.x * newPB.m_speed;
					newPB.m_velocity.y = newPB.m_direction.y * newPB.m_speed;
					newPB.Attach();
				}
			}
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}