// gtAssetManager.as
package GameTheater.gtSystems
{
	import flash.net.URLRequest;
    import flash.events.*;
	import flash.system.*;
	import flash.display.*;
	
	public dynamic class gtAssetManager
	{
		public static var m_loader:Array = new Array();
		public static var m_loaderPercents:Array = new Array();
		public static var m_loaderPercentsTotal:Array = new Array();
		public static var m_loading:int = 0;
		public static var m_loaded:Array = new Array();
		public static var m_percentLoaded:Number = 0;
		public static var m_percentTotal:Number = 0;
		
		public static function AutoLoad()
		{
			var dh = gtDataHouse.GetInstance();
			
			for each( var node:XML in dh.manifest.load )
			{	
				//gtLog.Add("loading "+node.@swf);
				m_loaded[node.@swf] = false;
				Load(node.@swf)
			}
		}
		
		var loader:Loader = null;
		public static function Load(what:String)
		{
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = flash.system.ApplicationDomain.currentDomain;

			if (loader == null)
			{
				var loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress)
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			}
			
			m_loading++;
			var UrlReq:URLRequest = new URLRequest(what);
			loader.load(UrlReq,context);
			
			if (m_loader)
				m_loader.push(loader);
				
			return loader;
		}
		
		public static function onProgress(e:ProgressEvent)
		{
			//trace(e.bytesLoaded,e.bytesTotal);
			if (e.bytesLoaded == 0)
			{
				//trace("new load");
				m_percentTotal += e.bytesTotal;
				m_loaderPercents[e.bytesTotal] = e.bytesLoaded;
				return;
			}
			else
			{
				m_loaderPercents[e.bytesTotal] = e.bytesLoaded;
			}
			
			var amount:Number = 0;
			
			for (var i:* in m_loaderPercents)
			{
				amount += m_loaderPercents[i];
				//trace("id",i,"value",m_loaderPercents[i],"total",amount);
			}
			
			m_percentLoaded = int((amount/m_percentTotal)*100);
			//trace("percent",m_percentLoaded);
		}
		
		public static function ioError(e:IOErrorEvent):void
		{
			//gtLog.Add(e.text);
			
			/*m_loading--;
			if (m_loading == 0)
			{
				gtLog.Add("Assets Loaded");
				m_loader.splice(0,m_loader.length);
				m_loader = null;
				m_loaded = null;
			}*/
		}
		
		public static function onLoaded(e:Event):void
		{
			var url = e.target.url
			var a = url.split("/");
			url = a[a.length-1];
			
			//gtLog.Add("Package " + url + " Loaded");
			m_loaded[url] = false;
			m_loading--;
			if (m_loading == 0)
			{
				gtLog.Add("Assets Loaded");
				m_loader.splice(0,m_loader.length);
				m_loader = null;
				m_loaded = null;
			}
		}
		
		public static function Loaded(s = null):Boolean
		{
			if (s != null && m_loaded != null)
			{
				return m_loaded[s];
			}
			
			return (m_loading == 0)?true:false;
		}
	}
}
		