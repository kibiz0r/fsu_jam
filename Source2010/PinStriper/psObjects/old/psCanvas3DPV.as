// psCanvas.as 
package PinStriper.psObjects
{
	import PinStriper.psSystems.*;
	import flash.display.MovieClip;
	import org.papervision3d.cameras.*;
	import org.papervision3d.scenes.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.special.*;
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.materials.special.*;
	import org.papervision3d.materials.shaders.*;
	import org.papervision3d.materials.utils.*;
	import org.papervision3d.lights.*;
	import org.papervision3d.render.*;
	import org.papervision3d.view.*;
	import org.papervision3d.events.*;
	import org.papervision3d.core.utils.*;
	import org.papervision3d.core.utils.virtualmouse.VirtualMouse;
	
	
	public class psCanvas3DPV extends psCanvas 
	{ 
		public var m_viewport:Viewport3D;
		public var m_scene:Scene3D;
		public var m_camera:Camera3D;
		public var m_renderer:BasicRenderEngine;
		
		public function psCanvas3DPV()
		{
			// Create viewport
			m_viewport = new Viewport3D(0, 0, false, true);
			addChild( m_viewport );
			
			m_renderer = new BasicRenderEngine();
			m_scene = new Scene3D();
			m_camera = new Camera3D();
			m_renderer.renderScene(m_scene, m_camera, m_viewport);
		}
		
		/*public override function Update(deltaT:Number)
		{
			m_renderer.renderScene(m_scene, m_camera, m_viewport);
		}*/
		
		public override function Resize(e:psEvent = null)
		{
			m_viewport.viewportWidth = psEasel.m_width;
			m_viewport.viewportHeight = psEasel.m_height;
		}
		
  	}
}