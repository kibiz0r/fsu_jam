// gtUIB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;
	
	public dynamic class gtLoaderB extends gtBehavior
	{
		public var m_loaders:Array = new Array();
		public function gtLoaderB()
		{
			m_name = "loader";
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			for (var i:int = 0; i < m_loaders.length; i++)
				Unload(m_loaders[i]);
			m_loaders = new Array();
			super.Destructor();
		}
		
		
		// Listeners
		public function loadComplete(e:Event)
		{
			var temp = new Object();
			temp.m_name = e.target.loader.name;
			temp.m_loader = e.target.loader;
			
			gameObject.SendMessage("Loaded",temp);
		}
		
		public function ioErrorHandler(e:IOErrorEvent)
		{
			trace(e);
			Unload(e.target.loader.name);
			
			var temp = new Object();
			temp.m_name = e.target.loader.name;
			temp.m_error = e;
			
			gameObject.SendMessage("LoadError",temp);
		}
		
		public function Load(n,url)
		{
			if (this[n] != null)
			{
				trace("loader already exists",n);
				return;
			}
			
			var tempLoader:Loader = new Loader();
			
			tempLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			tempLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			tempLoader.load(new URLRequest(url));
			tempLoader.name = n;
			
			m_loaders.push(n);
			
			this[n] = tempLoader;
			return this[n];
		}
		
		public function LoadURL(n,url)
		{
		}
		
		public function Unload(n)
		{
			if (this[n] != null)
			{
				var temp = this[n]
				Cancel(n);
				temp.unload();
			}
		}
		
		public function Cancel(n)
		{
			if (this[n] != null)
			{
				this[n].close();
				this[n].contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
				this[n].contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				this[n] = null;
				delete(this[n]);
				m_loaders.splice(m_loaders.indexOf(n),1);
			}
		}
	}
}