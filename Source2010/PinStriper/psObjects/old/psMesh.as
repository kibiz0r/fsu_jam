// psMesh.as 
package PinStriper.psObjects
{
	import flash.display.MovieClip;
	import flash.geom.*;
	
	
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
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
	import org.papervision3d.core.proto.*;
	import org.papervision3d.core.utils.virtualmouse.VirtualMouse;
	import org.papervision3d.objects.parsers.*;
	
	public class psMesh
	{
		public var m_mesh:Collada;
		public var m_scene;
		public var m_loaded:Boolean = false;
		
		public function psMesh()
		{
			
		}
		
		public function Load(file:String,scale:Number = 1)
		{
			try
			{
				m_mesh = new Collada(file, null, scale);
				m_mesh.addEventListener(FileLoadEvent.LOAD_COMPLETE,Loaded);
				m_mesh.addEventListener(FileLoadEvent.COLLADA_MATERIALS_DONE,MatLoaded)
			}
			catch(e:Error)
			{
				trace("psMesh Load",e.message);
			}
		}
		
		public function Insert(scene:String)
		{
			m_scene = psEasel.GetCanvas(scene).m_scene;
			if (m_loaded)
				m_scene.addChild(m_mesh);
			
		}
		
		public function Loaded(e:FileLoadEvent)
		{
			trace("psMesh Loaded");
		}
		
		public function MatLoaded(e:FileLoadEvent)
		{
			m_loaded = true;
			trace("psMesh Materials Loaded");
			if (m_scene)
				m_scene.addChild(m_mesh);
		}
  	}
}