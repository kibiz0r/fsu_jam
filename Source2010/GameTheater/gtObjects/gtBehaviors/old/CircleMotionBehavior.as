// CircleMotionBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class CircleMotionBehavior extends Behavior
	{
		public function CircleMotionBehavior()
		{
			m_orderWeight = 0.8;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			o.cx = 0;
			o.cy = -1;
			o.target_cy = 0;
			o.m_speed = 0;
			o.m_rotation = 0;
			o.m_circleRotate = true;
			o.m_direction = new psVec2();
			o.m_surface = null;
			o.m_hover = 0;
			o.m_radialWidth = 1;
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			
			if (o.cx < 0)
				o.cx = 360 + o.cx;
			
			if (o.cx > 360)
				o.cx = o.cx - 360;
				
			if (o.m_surface)
			{
				var index = int((o.m_surface.m_heightData.length)*(((o.cx)%360)/360));
				
				var h1:Number = o.m_surface.m_heightData[index];
				var h2:Number = o.m_surface.m_heightData[index+1];
				
				var diff = h2 - h1;
				
				var deg = 360/o.m_surface.m_heightData.length;
				
				var d1 = index * deg;
				
				var dDiff = o.cx - d1;
				var per = dDiff/deg;
				
				var t = h1 + (diff * per);
				
				o.target_cy = t + o.m_hover;
				if (o.cy == -1)
					o.cy = o.target_cy;
			}
			
			
			if (o.target_cy > o.cy)
			{
				o.cy += 50 * (gtTime.deltaT*0.001);
				
				if (o.target_cy < o.cy)
				{
					o.cy = o.target_cy;
				}
			}
			else if (o.target_cy < o.cy)
			{
				o.cy -= 50 * (gtTime.deltaT*0.001);
				
				if (o.target_cy > o.cy)
				{
					o.cy = o.target_cy;
				}
			}
						
			o.x = Math.cos(((o.cx)%360)*(Math.PI/180))*o.cy;
			o.y = Math.sin(((o.cx)%360)*(Math.PI/180))*o.cy;
			
			var up:psVec2 = new psVec2(-o.x,-o.y);
			up.normalize();
			
			o.m_direction = up;
			
			o.m_rotation = Math.atan(up.y/up.x) * (180 /Math.PI);
			o.m_rotation += 90;
			
			if (up.x <= 0)
				o.m_rotation += 180;
			
			o.m_rotation += 180;
		
			if (o.m_circleRotate)
				o.rotation = o.m_rotation;
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}