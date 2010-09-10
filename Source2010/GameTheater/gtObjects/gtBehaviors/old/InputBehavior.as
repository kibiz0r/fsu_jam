// InputBehavior.as 
package GameTheater
{
	
	import flash.ui.*
	import GameTheater.*;
	import PinStriper.psTools.*;
	
	public class InputBehavior extends Behavior
	{
		public function InputBehavior()
		{
			m_orderWeight = 0.5;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			o.m_input = psInput.GetInstance();
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			if (o.m_input.KeyDown(Keyboard.LEFT))
			{
				o.m_rotation -= 280*(gtTime.deltaT*0.001);
				o.m_rotVel = 0;
				o.m_direction.x = Math.cos((o.m_rotation-90)*(Math.PI/180));
				o.m_direction.y = Math.sin((o.m_rotation-90)*(Math.PI/180));
			}
			if (o.m_input.KeyDown(Keyboard.RIGHT))
			{
				o.m_rotation += 280*(gtTime.deltaT*0.001);
				o.m_rotVel = 0;
				o.m_direction.x = Math.cos((o.m_rotation-90)*(Math.PI/180));
				o.m_direction.y = Math.sin((o.m_rotation-90)*(Math.PI/180));
			}
			if (o.m_input.KeyDown(Keyboard.UP))
			{
				o.m_velocity.x += (o.m_direction.x * o.m_speed)*(gtTime.deltaT*0.001);
				o.m_velocity.y += (o.m_direction.y * o.m_speed)*(gtTime.deltaT*0.001);
				if (o.m_velocity.len() > 400)
				{
					o.m_velocity.normalize();
					o.m_velocity.scale(400);
				}
			}
			if (o.m_input.KeyDown(Keyboard.DOWN))
			{
				//o.m_velocity.x -= (o.m_direction.x * o.m_speed)*(gtTime.deltaT*0.001);
				//o.m_velocity.y -= (o.m_direction.y * o.m_speed)*(gtTime.deltaT*0.001);
				o.m_velocity.x *= 0.8;
				o.m_velocity.y *= 0.8;
			}
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}