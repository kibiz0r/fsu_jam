// psCamera.as 
package PinStriper.psObjects
{
	import flash.ui.*;
	import flash.geom.*;
	import fl.transitions.Tween;
	import fl.motion.easing.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;

	public class psCamera3D
	{
		public var m_sm:gtAdvancedStateMachine;
		public var m_canvas:psCanvas;
		
		public var m_target;
		
		public var m_stageWidth:Number;
		public var m_stageHeight:Number;
		
		public var m_zoomX:Tween;
		public var m_zoomY:Tween;
		public var m_moveX:Tween;
		public var m_moveY:Tween;
		public var m_focusing:Boolean = false;
		

		public function psCamera3D()
		{
			m_sm = new gtAdvancedStateMachine();
			m_sm.NewState("Debug",Debug);
			m_sm.NewState("Idle",Idle);
			m_sm.NewState("Follow",Follow);
			m_sm.NewState("World",World);
			
			m_sm.ActivateState("Idle");
		}
		
		public function OnScreen(obj):Boolean
		{
			var p = obj.localToGlobal(new Point(0,0));
			if ((p.x - obj.width) < 0 || (p.x + obj.width) > 800)
				return false;
			if ((p.y - obj.height) < 0 || (p.y) > 600)
				return false;
			return true;
		}
		
		public function FollowObject(t)
		{
			m_target = t;
			m_sm.ActivateState("Follow");
		}
		
		public function LookAt(t)
		{
			
		}
		
		public function Focus(obj, zoom = 1, trans = null, time = 2)
		{
			//psLog.Add(psEasel.m_stage.stageWidth);
			var oldScale = m_canvas.scaleX;
			m_canvas.scaleX = m_canvas.scaleY = zoom;
			var temp2 = obj.localToGlobal(new Point(0,0));

			//psLog.Add(temp2.x);
			if (trans)
			{
				m_focusing = true;
				m_zoomX = new Tween(m_canvas, "scaleX", trans, oldScale, zoom, time, true);
				m_zoomY = new Tween(m_canvas, "scaleY", trans, oldScale, zoom, time, true);
				m_moveX = new Tween(m_canvas, "x", trans, m_canvas.x, m_canvas.x + (psEasel.m_stage.stageWidth/2) - temp2.x, time, true);
				m_moveY = new Tween(m_canvas, "y", trans, m_canvas.y, m_canvas.y + (psEasel.m_stage.stageHeight/2) - temp2.y, time, true);
			}
			else
			{
				m_canvas.x += (psEasel.m_stage.stageWidth/2) - temp2.x;
				m_canvas.y += (psEasel.m_stage.stageHeight/2) - temp2.y;
			}
		}
		
		public function Zoom(z)
		{
			var temp = new Point(psEasel.m_stage.stageWidth/2,psEasel.m_stage.stageHeight/2);
			temp = m_canvas.globalToLocal(temp);
			m_canvas.scaleX = m_canvas.scaleY = z;
			var temp2 = m_canvas.localToGlobal(temp);
			m_canvas.x += (psEasel.m_stage.stageWidth/2) - temp2.x;
			m_canvas.y += (psEasel.m_stage.stageHeight/2) - temp2.y;
		}
		
		public function Debug(setting:int)
		{
			if (setting == gtState.ENTER_STATE)
			{
			}
			else if (setting == gtState.NORMAL_STATE)
			{
				if (gtInput.GetInstance().KeyDown(Keyboard.SHIFT))
				{
					if (gtInput.GetInstance().KeyDown(Keyboard.UP))
					{
						m_canvas.y += 400 * (gtTime.deltaT*0.001);
					}
					else if (gtInput.GetInstance().KeyDown(Keyboard.DOWN))
					{
						m_canvas.y -= 400 * (gtTime.deltaT*0.001);
					}
					if (gtInput.GetInstance().KeyDown(Keyboard.LEFT))
					{
						m_canvas.rotationY -= 400 * (gtTime.deltaT*0.001);
					}
					else if (gtInput.GetInstance().KeyDown(Keyboard.RIGHT))
					{
						m_canvas.rotationY += 400 * (gtTime.deltaT*0.001);
					}
				}
				else
				{
					if (gtInput.GetInstance().KeyDown(Keyboard.UP))
					{
						m_canvas.z -= 400 *(gtTime.deltaT*0.001);
					}
					else if (gtInput.GetInstance().KeyDown(Keyboard.DOWN))
					{
						m_canvas.z += 400 * (gtTime.deltaT*0.001);
					}
					if (gtInput.GetInstance().KeyDown(Keyboard.LEFT))
					{
						m_canvas.x += 400* (gtTime.deltaT*0.001);
					}
					else if (gtInput.GetInstance().KeyDown(Keyboard.RIGHT))
					{
						m_canvas.x -= 400 * (gtTime.deltaT*0.001);
					}
				}
				if (gtInput.GetInstance().KeyReleased(gtInput.D))
				{
					m_sm.LastState();
				}
			}
			else if (setting == gtState.EXIT_STATE)
			{
			}
		}
		
		public function Idle(setting:int)
		{
			if (setting == gtState.ENTER_STATE)
			{
			}
			else if (setting == gtState.NORMAL_STATE)
			{
				//m_canvas.rotationY++;
				
			}
			else if (setting == gtState.EXIT_STATE)
			{
			}
		}
		
		public function Follow(setting:int)
		{
			if (setting == gtState.ENTER_STATE)
			{
			}
			else if (setting == gtState.NORMAL_STATE)
			{
				LookAt(m_target);
			}
			else if (setting == gtState.EXIT_STATE)
			{
			}
		}
		
		public function World(setting:int)
		{
			if (setting == gtState.ENTER_STATE)
			{
				//m_canvas.rotationY = m_target.Current().angle;
				m_canvas.x = psEasel.m_stage.stageWidth/2;
				m_canvas.y = psEasel.m_stage.stageHeight/2 + 145;
				m_canvas.z = -500;
				
				m_canvas.rotationX = 0;
				m_canvas.rotationY = 0;
				m_canvas.rotationZ = 0;
				
				//m_canvas.y = 145;
				//m_canvas.z -= 400;
			}
			else if (setting == gtState.NORMAL_STATE)
			{
				//m_canvas.rotationX = -1 + ((psEasel.m_root.mouseY/psEasel.m_stage.stageHeight)*2);
				m_canvas.rotationY = -1 + ((psEasel.m_root.mouseX/psEasel.m_stage.stageWidth)*2);
				//m_canvas.rotationZ = -1 + ((psEasel.m_root.mouseX/psEasel.m_stage.stageWidth)*2);
				
				if (gtInput.GetInstance().KeyReleased(gtInput.D))
				{
					m_sm.ActivateState("Debug");
				}
			}
			else if (setting == gtState.EXIT_STATE)
			{
			}
		}
	}
}