// psCanvas.as 
package PinStriper.psObjects
{
	import flash.display.MovieClip;
	import flash.geom.*;
	
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class psCanvas3D extends psCanvas 
	{ 
		public var m_camera:psCamera3D;
		
		public function psCanvas3D()
		{
			m_camera = new psCamera3D();
			
			m_camera.m_canvas = this;
			m_camera.m_stageWidth = psEasel.m_stage.stageWidth;
			m_camera.m_stageHeight = psEasel.m_stage.stageHeight;
		}
		
		/*public override function Update(deltaT:Number)
		{
			m_camera.Update(deltaT);
		}*/
		
		public override function Resize(e:psEvent = null)
		{
			root.transform.perspectiveProjection.projectionCenter = new Point(stage.stageWidth/2, stage.stageHeight/2); 
		}
  	}
}