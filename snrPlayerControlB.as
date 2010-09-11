package
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;

	public dynamic class snrPlayerControlB extends gtBehavior
	{
		public var m_speed:Number = 800;
		public var m_vx:Number = 0;
		public var m_vy:Number = 0;
		
		public function snrPlayerControlB()
		{
			m_name = "gob"
		}
		
		public override function Awake()
		{
			gameObject.content = new SamuraiNinjaRabbit();
			//snrBackgroundB.that.m_vy = 100;
			
			states.Add("Play", Play, "Default").Update();
		}
		
		public override function Start()
		{
			states.Activate("Play");
		}
		
		public function Play(setting:int)
		{
			if (setting == gtState.INIT)
			{
				
			}
			else if (setting == gtState.UPDATE)
			{
				/*if (gtInput.KeyDown(gtInput.W))
				{
					
				}*/
				if (gtInput.KeyDown(gtInput.S))
				{
					//m_vx *= -1;
					//m_vy *= -1;
				}
				if (gtInput.KeyDown(gtInput.A))
				{
					gameObject.rotation -= (60 * (gtTime.deltaT / 1000));
				}
				else if (gtInput.KeyDown(gtInput.D))
				{
					gameObject.rotation += (60 * (gtTime.deltaT / 1000));
				}
				
				m_vx = Math.cos(((gameObject.rotation + 90) * (Math.PI/180))) * m_speed;
				m_vy = Math.sin(((gameObject.rotation + 90) * (Math.PI/180))) * m_speed;
				
				UpdateMovements();
			}
			else if (setting == gtState.EXIT)
			{
				
			}
		}
		
		public function UpdateMovements()
		{
			var m_buffer = 120;
			
			var t_vx = m_vx * (gtTime.deltaT / 1000);
			var t_vy = m_vy * (gtTime.deltaT / 1000);
			
			var c_vx = t_vx / -3;
			var c_vy = t_vy / -3;
			
			var b_vx = t_vx + c_vx;
			var b_vy = t_vy + c_vy;
			
			gameObject.x += c_vx;
			gameObject.y += c_vy;
			
			if(gameObject.x < (psEasel.that.m_width / -2) + m_buffer || gameObject.x > (psEasel.that.m_width / 2) - m_buffer)
			{
				gameObject.x -= c_vx;
				b_vx -= c_vx;
			}
			
			if(gameObject.y < (psEasel.that.m_height / -2) + m_buffer || gameObject.y > (psEasel.that.m_height / 2) - m_buffer)
			{
				gameObject.y -= c_vy;
				b_vy -= c_vy;
			}
			
			snrBackgroundB.that.UpdateMovements(b_vx, b_vy);
		}
	}
}