﻿package
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;

	public dynamic class snrPlayerControlB extends gtBehavior
	{
		public var m_speed:Number = 800;
		public var m_slowDownSpeed:Number = 1600;
		public var m_turnSpeed:Number = 90;
		public var m_vx:Number = 0;
		public var m_vy:Number = 0;
		
		public function snrPlayerControlB()
		{
			m_name = "gob";
		}
		
		public override function Awake()
		{
			gameObject.content = new SamuraiNinjaRabbit();
			gameObject.actor.Attach(psEasel.GetCanvas("gameSpace"));
			//snrBackgroundB.that.m_vy = 100;
			
			states.Add("Play", Play, "Default").Update().Reactivate();
			states.Add("TurnAround", TurnAround, "Default").Update().Reactivate();
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
				if (gtInput.KeyPressed(gtInput.S))
				{
					states.Activate("TurnAround");
				}
				if (gtInput.KeyDown(gtInput.A))
				{
					gameObject.rotation -= (m_turnSpeed * (gtTime.deltaT / 1000));
				}
				else if (gtInput.KeyDown(gtInput.D))
				{
					gameObject.rotation += (m_turnSpeed * (gtTime.deltaT / 1000));
				}
				
				m_vx = Math.cos(((gameObject.rotation + 90) * (Math.PI/180))) * m_speed;
				m_vy = Math.sin(((gameObject.rotation + 90) * (Math.PI/180))) * m_speed;
				
				UpdateMovements();
			}
			else if (setting == gtState.EXIT)
			{
				
			}
		}
		
		public function TurnAround(setting:int)
		{
			if (setting == gtState.INIT)
			{
				gameObject.content.rotation = 90;
			}
			else if (setting == gtState.UPDATE)
			{
				var decel_x = Math.cos((gameObject.rotation + 90) * Math.PI / 180) * m_slowDownSpeed * gtTime.deltaT / 1000;
				var decel_y = Math.sin((gameObject.rotation + 90) * Math.PI / 180) * m_slowDownSpeed * gtTime.deltaT / 1000;
				if (m_vx == 0 || (m_vx > 0 ? decel_x > m_vx : decel_x < m_vx)) // When we're about to transition from left-to-right to right-to-left or vice-versa
				{
					m_vx = 0;
				}
				else
				{
					m_vx -= decel_x;
				}
				if (m_vy == 0 || (m_vy > 0 ? decel_y > m_vy : decel_y < m_vy))
				{
					m_vy = 0;
				}
				else
				{
					m_vy -= decel_y;
				}
				if (m_vx == 0 && m_vy == 0)
				{
					states.Activate("Play");
				}
				else
				{
					UpdateMovements();
				}
			}
			else if (setting == gtState.EXIT)
			{
				gameObject.content.rotation = 0;
				gameObject.rotation -= 180;
			}
		}
		
		public function UpdateMovements()
		{
			var m_buffer = 180;
			
			var t_vx = m_vx * (gtTime.deltaT / 1000);
			var t_vy = m_vy * (gtTime.deltaT / 1000);
			
			var c_vx = (t_vx * 2) / -5;
			var c_vy = (t_vy * 2) / -5;
			
			var b_vx = t_vx + c_vx;
			var b_vy = t_vy + c_vy;
			
			gameObject.x += c_vx;
			gameObject.y += c_vy;
			
			if(gameObject.x < (psEasel.that.m_width / -2) + m_buffer)
			{
				gameObject.x = (psEasel.that.m_width / -2) + m_buffer;
				b_vx -= c_vx;
			}
			else if (gameObject.x > (psEasel.that.m_width / 2) - m_buffer)
			{
				gameObject.x = (psEasel.that.m_width / 2) - m_buffer;
				b_vx -= c_vx;
			}
			
			if(gameObject.y < (psEasel.that.m_height / -2) + m_buffer)
			{
				gameObject.y = (psEasel.that.m_height / -2) + m_buffer;
				b_vy -= c_vy;
			}
			else if (gameObject.y > (psEasel.that.m_height / 2) - m_buffer)
			{
				gameObject.y = (psEasel.that.m_height / 2) - m_buffer;
				b_vy -= c_vy;
			}
			
			snrBackgroundB.that.UpdateMovements(b_vx, b_vy);
		}
	}
}