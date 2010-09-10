// psCanvas.as 
package PinStriper.psObjects
{
	import PinStriper.psSystems.*;
	import PinStriper.psObjects.*;
	import PinStriper.psTools.*;
	import flash.display.Sprite;
	
	public class psCanvas extends Sprite 
	{
		public static const CANVAS_STANDARD:int = 0;
		public static const CANVAS_SCALE:int = 1;
		
		public var m_mode:int = CANVAS_STANDARD;
		
		public var m_defaultWidth:Number = 0;
		public var m_defaultHeight:Number = 0;
		
		public function psCanvas(m)
		{
			m_mode = m;
			psEasel.that.addEventListener(psEvent.RESIZE,Resize);
		}
		
		public function SetDefaultResolution(w,h)
		{
			m_defaultWidth = w;
			m_defaultHeight = h;
			Resize();
		}
		
		public function Resize(e:psEvent = null)
		{
			if (m_mode == CANVAS_SCALE)
			{
				
				scaleX = psEasel.that.m_width/m_defaultWidth;
				scaleY = psEasel.that.m_height/m_defaultHeight;
			}
			else if (m_mode == CANVAS_STANDARD)
			{
				scaleX = scaleY = 1;
			}
			
			if (psEasel.that.m_fillHorizontal)
			{
				//x  = (stage.stageWidth-psEasel.that.m_width)/2;
			}
		}
  	}
}