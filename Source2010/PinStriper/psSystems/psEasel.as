// psEasel.as 
package PinStriper.psSystems
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	import GameTheater.gtSystems.*;

	import flash.geom.*;
	
	public dynamic class psEasel extends Sprite
	{ 
		private var m_objects = new Object();
		
		private var m_currentCamera:String = "";
		
		private var m_resolutions:Array = new Array();
		public var m_baseResolution = new psVec2(0,0);
		public var m_perspective = new psVec2(0,0);
		private var m_currentResolution:int = -1;
		
		private var m_dynamicResize:Boolean = true;
		public var m_fillHorizontal:Boolean = false;
		public var m_fillVertical:Boolean = false;
		public var m_top:Boolean = false;
		
		public var m_width:int = 0;
		public var m_height:int = 0;
		
		public static var that = null;
	
		public static function Setup(X,Y,... args)
		{
			if (that == null)
				that = new psEasel(X,Y,args);
			return that;
		}
		
		public function psEasel(X,Y,a:Array)
		{
			
			main.that.addChild(this);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
		  	stage.align = StageAlign.TOP_LEFT;
			
			stage.addEventListener(Event.RESIZE,Resize);
			
			m_baseResolution.x = X;
			m_baseResolution.y = Y;
			
			m_perspective.x = 0.5;
			m_perspective.y = 0.5;
			
			a.sort(Array.NUMERIC);
			for (var i:int = 0; i < a.length; i++)
				m_resolutions.push(new psVec2(a[i]*m_baseResolution.x,a[i]*m_baseResolution.y));
			
			//if (a.length > 1)
//			{
				Resize();
			//}
//			else
//			{
				//m_dynamicResize = false;
				//ChangeResolution(0);
			//}
		}
		
		//Settings
		public function FillHorizontal()
		{
			if (m_dynamicResize)
			{
				m_fillHorizontal = true;
				Resize();
			}
			else
				trace("you cannot have fill horizontal and fixed resolution");
				
			return this;
		}
		
		public function FillVertical()
		{
			if (m_dynamicResize)
			{
				m_fillVertical = true;
				Resize();
			}
			else
				trace("you cannot have fill vertical and fixed resolution");
				
			return this;
		}
		
		public function Top()
		{
			m_top = true;
			Resize();
			return this;
		}
		
		// Listeners
		public function Resize(e:Event = null)
		{
			if (m_dynamicResize)
			{
				for (var i = m_resolutions.length-1; i > -1; i--)
				{
					if (m_resolutions[i].x <= root.stage.stageWidth || m_fillHorizontal)
					{
						if (m_resolutions[i].y <= root.stage.stageHeight || m_fillVertical)
						{
							ChangeResolution(i);
							return;
						}
					}
				}
				ChangeResolution(0);
			}
			else
				FixFrame();
		}
		
		//Controls
		public function ChangeResolution(r)
		{
			m_currentResolution = r;
			
			if (m_fillHorizontal)
				m_width = root.stage.stageWidth;
			else
				m_width = m_resolutions[m_currentResolution].x;
			
			if(m_fillVertical)
				m_height = root.stage.stageHeight;
			else
				m_height = m_resolutions[m_currentResolution].y;
			
			if (m_top)
				scrollRect = new Rectangle((-m_width*0.5),(-m_height*0.5)+((m_height-m_baseResolution.y)*0.5),m_width,m_height);
			else
				scrollRect = new Rectangle((-m_width*0.5),(-m_height*0.5),m_width,m_height);
			root.transform.perspectiveProjection.projectionCenter = new Point(m_perspective.x * m_width, m_perspective.y * m_height);
			//trace(root.transform.perspectiveProjection.projectionCenter);
			FixFrame();
		}
		
		private function FixFrame()
		{
			//center
			/*x = (root.stage.stageWidth-m_width)*0.5;
			
			if (m_top)
				y = 0;
			else
				y = (root.stage.stageHeight-m_height)*0.5;*/
			
			
			dispatchEvent(new psEvent(psEvent.RESIZE));
		}
		
		//Static Interfaces
		public static function SetPerspective(X,Y)
		{
			that.m_perspective.x = X;
			that.m_perspective.y = Y;
			that.Resize();
		}
		
		public static function AddCanvas(c:String,m = 0)
		{
			that.m_objects[c] = new psCanvas(m);
			that.addChild(that.m_objects[c]);
			that.m_objects[c].SetDefaultResolution(that.m_baseResolution.x,that.m_baseResolution.y);
			return that.m_objects[c];
		}
		
		public static function GetCanvas(c:String)
		{	
			return that.m_objects[c];
		}
		
		/*public static function AddCamera(cam,canvas)
		{
			that.m_objects[cam] = new psCamera();
			that.m_objects[cam].m_canvas = GetCanvas(canvas);
			
			if (that.m_currentCamera == "")
				that.m_currentCamera = cam;
			
			return that.m_objects[cam];
		}
		
		
		
		public static function GetCamera(c = ""):psCamera
		{
			if (c == "")
				c = that.m_currentCamera;
				
			return that.m_objects[c];
		}*/
	}
}