// DataHouse.as
package GameTheater.gtSystems
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public dynamic class gtDataHouse extends Sprite
	{ 
		public static var m_instance = null;
		
		public function gtDataHouse()
		{
		}
		
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new gtDataHouse;

			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}
		
		public function Load(s)
		{
			var loader:URLLoader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, this.cbLoad);
			loader.addEventListener(IOErrorEvent.IO_ERROR, this.cbLoadError);
			loader.load(new URLRequest(s));
		}
		
		public function AddData(name:String,o:Object)
		{
			this[name] = o;
		}
		
		public function cbLoad(event:Event):void
		{
			try
			{
				var xml:XML = new XML(event.target.data);
				gtDataHouse.GetInstance()[xml.name()] = xml;
			}
			catch (e:TypeError)
			{
				trace("XML Load Error");
				trace(e.message);
			}
		}
		
		public function cbLoadError(event:Event):void
		{
			trace(event);
		}
		
		private function Store(parentNode:XML = null, parent:gtData = null):void
		{
			var nodes:XMLList;
			var node:XML;
			var fix:Number = 0;
			
			if (parent == null)
			{
				gtDataHouse.GetInstance()[parentNode.name()] = new gtData();
				gtDataHouse.GetInstance()[parentNode.name()].m_name = parentNode.name();
				parent = gtDataHouse.GetInstance()[parentNode.name()];
				//psLog.Add("DataHouse." + parentNode.name() + " created");
			}
			
			if(parentNode.children().length)
			{
				nodes = parentNode.children();
				
				//psLog.Add("node len - " + nodes.length());
				for (var i = 0; i < nodes.length(); i++)
				{
					node = XML(nodes[i]);
					if (!node.name())
						continue;
					var obj = new gtData();
					obj.m_name = node.name();
					// Store the Attributes
					for (var j = 0; j < node.attributes().length(); j++)
					{
						obj.m_attributes[node.attributes()[j].name().toString()] = node.attributes()[j].toString();
						obj.m_atypes.push(node.attributes()[j].name().toString());
					}
					
					// store the children xml plain text
					obj.m_xml = node.children().toString();
					
					// see if we can handle this type of object
					if( parent.m_children[obj.m_name] == null )
					{
						//psLog.Add(obj.m_name + " added array to " + parent.m_name);
						parent.m_children[obj.m_name] = new Array();
						parent.m_types.push(obj.m_name);
					}
					
					// uses the id and index if it needs it
					if (obj.m_attributes["id"] != undefined)
						parent.m_children[obj.m_name]["id_" + obj.m_attributes["id"]] = obj;
					if (obj.m_attributes["index"] != undefined)
						parent.m_children[obj.m_name]["index_" + obj.m_attributes["index"]] = obj;
					//else
					//{
						// adds it the old fashioned way
					parent.m_children[obj.m_name].push(obj);
					//}
					//psLog.Add(obj.m_name + " added to " + parent.m_name);
					
					this.Store( node, obj);
				}
			}
		}		
  	}
}