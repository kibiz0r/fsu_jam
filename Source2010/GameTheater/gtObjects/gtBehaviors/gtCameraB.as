// gtCameraB.as 
package GameTheater.gtObjects.gtBehaviors
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

	public dynamic class gtCameraB extends gtBehavior
	{
		public static const GTCAMERA:String = "gtCameraB";
		
		public var m_canvas:psCanvas;
		
		public var m_target:gtGameObject;
		
		public var m_zoomX:Tween;
		public var m_zoomY:Tween;
		public var m_moveX:Tween;
		public var m_moveY:Tween;
		public var m_focusing:Boolean = false;
		
		public var oldX:Number = 0;
		public var oldY:Number = 0;
		
		public function gtCameraB()
		{
			m_name = "camera";
		}
		
		public override function Awake()
		{
			states.Add("Camera_Shake",Camera_Shake,GTCAMERA).Update();
			states.Add("Camera_Idle",Camera_Idle,GTCAMERA);
			states.Add("Camera_Follow",Camera_Follow,GTCAMERA).Update();
			states.Add("Camera_Debug",Camera_Debug,GTCAMERA).Update();
			states.Activate("Camera_Idle");
		}
		
		public override function Start()
		{
			
		}
		
		public override function Destructor()
		{
		}
		
		// Settings
		public function SetCanvas(c:String)
		{
			m_canvas = psEasel.GetCanvas(c);
			return this;
		}

		// Controls
		public function Follow(t)
		{
			m_target = t;
			states.Activate("Follow");
		}
		
		public function Shake(b)
		{
			if (b)
				states.Activate("Camera_Shake");
			else
				states.LastState(GTCAMERA);
		}
		
		public function Focus(obj, zoom = 1, trans = null, time = 2)
		{
			var oldScale = m_canvas.scaleX;
			m_canvas.scaleX = m_canvas.scaleY = zoom;
			var temp2 = obj.localToGlobal(new Point(0,0));

			if (trans)
			{
				m_focusing = true;
				m_zoomX = new Tween(m_canvas, "scaleX", trans, oldScale, zoom, time, true);
				m_zoomY = new Tween(m_canvas, "scaleY", trans, oldScale, zoom, time, true);
				m_moveX = new Tween(m_canvas, "x", trans, m_canvas.x, m_canvas.x + (psEasel.that.stage.stageWidth/2) - temp2.x, time, true);
				m_moveY = new Tween(m_canvas, "y", trans, m_canvas.y, m_canvas.y + (psEasel.that.stage.stageHeight/2) - temp2.y, time, true);
			}
			else
			{
				m_canvas.x += (psEasel.that.stage.stageWidth/2) - temp2.x;
				m_canvas.y += (psEasel.that.stage.stageHeight/2) - temp2.y;
			}
		}
		public function Zoom(z)
		{
			var temp = new Point(psEasel.that.stage.stageWidth/2,psEasel.that.stage.stageHeight/2);
			temp = m_canvas.globalToLocal(temp);
			m_canvas.scaleX = m_canvas.scaleY = z;
			var temp2 = m_canvas.localToGlobal(temp);
			m_canvas.x += (psEasel.that.stage.stageWidth/2) - temp2.x;
			m_canvas.y += (psEasel.that.stage.stageHeight/2) - temp2.y;
		}
		
		//States
		public function Camera_Idle(setting:int)
		{
			
		}
		
		public function Camera_Shake(setting:int)
		{
			if (setting == gtState.ENTER)
			{
				oldX = m_canvas.x;
				oldY = m_canvas.y;
				m_canvas.scaleX += 0.01;
				m_canvas.scaleY += 0.01;
 			}
			else if (setting == gtState.UPDATE)
			{ 
				m_canvas.x = oldX + Math.random() * -3;
				m_canvas.y = oldY + Math.random() * -3;
			}
			else if (setting == gtState.EXIT)
			{
				m_canvas.scaleX -= 0.01;
				m_canvas.scaleY -= 0.01;
				m_canvas.x = oldX;
				m_canvas.y = oldY;
			}
		}
		
		public function Camera_Follow(setting:int)
		{
			if (setting == gtState.ENTER)
			{
				Focus(m_target,1);
 			}
			else if (setting == gtState.UPDATE)
			{
				if (!m_target.OnScreen() && !m_focusing)
					Focus(m_target,1,Linear.easeInOut,0.5);
			}
		}
		
		public function Camera_Debug(setting:int)
		{
			if (setting == gtState.UPDATE)
			{
				if (gtInput.KeyDown(Keyboard.SHIFT))
				{
					if (gtInput.GetInstance().KeyPressed(Keyboard.UP))
					{
						Zoom(m_canvas.scaleX + 0.2);
					}
					else if (gtInput.GetInstance().KeyPressed(Keyboard.DOWN))
					{
						Zoom(m_canvas.scaleX - 0.2);
					}
				}
				else
				{
					if (gtInput.KeyDown(Keyboard.UP))
					{
						m_canvas.y += 400 * m_canvas.scaleX *(gtTime.deltaT*0.001);
					}
					else if (gtInput.KeyDown(Keyboard.DOWN))
					{
						m_canvas.y -= 400 * m_canvas.scaleX * (gtTime.deltaT*0.001);
					}
					if (gtInput.KeyDown(Keyboard.LEFT))
					{
						m_canvas.x += 400 * m_canvas.scaleX * (gtTime.deltaT*0.001);
					}
					else if (gtInput.KeyDown(Keyboard.RIGHT))
					{
						m_canvas.x -= 400 * m_canvas.scaleX * (gtTime.deltaT*0.001);
					}
				}
			}
		}
	}
}