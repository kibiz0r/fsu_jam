// gtObjects.as 
package GameTheater.gtSystems
{
	import flash.geom.*;
	import flash.utils.*;
	
	import GameTheater.gtObjects.*;
	
	public class gtObjects
	{
		public static var m_types:Object = new Object();
		
		public static function Report()
		{
			for(var type:String in m_types)
			{
				trace(m_types[type].length + " " + type);
			}
		}
		
		public static function ReportString()
		{
			var total:int = 0;
			var temp:String = new String();
			for(var type:String in m_types)
			{
				temp += "" + type + ": " + m_types[type].length + "\n";
				total += m_types[type].length;
			}
			
			temp += "Total Objects: " + total + "\n";
			temp += "State Update Loops: " + gtState.m_count + "\n";
			return temp;
		}
		
		public static function CleanUp()
		{
			for(var type:String in m_types)
			{
				for (var i:int = 0; i < m_types[type].length; i++)
				{
					 m_types[type][i].Destructor();
					 m_types[type][i] = null;
				}
				m_types[type] = null;
			}
		}
		
		public static function LookupType(type:String):Vector.<gtObject>
		{
			if (m_types[type] == null)
			{
				m_types[type] = new Vector.<gtObject>();
			}
			return m_types[type];
		}
		
		public static function Create(type:Class):Object
		{
			var temp = getQualifiedClassName(type).split("::")[1];
			if (!temp)
				temp = getQualifiedClassName(type).split("::")[0];
			
			var newObject = null;
			
			if (m_types[temp+"_recycled"] != null && m_types[temp+"_recycled"].length > 0)
			{
				//trace("recycled",temp);
				newObject = m_types[temp+"_recycled"].pop();
				newObject.Enable();
			}
			else
			{
				
				//trace("created",temp);
				/*var c = null;
				if (type == "gtGameObject")
					c = gtGameObject;
				else
					c = getDefinitionByName(type) as Class;*/
				
				newObject = new type();
			}
			return newObject;
		}   
		
		public static function Add(newObject:Object)
		{
			if (!newObject)
				return;
		
			var typeArray = LookupType(newObject.type);
			newObject.m_managed = true;
			typeArray.push(newObject);
		}
		
		public static function Recycle(recycleObject:Object)
		{
			if (m_types[recycleObject.type+"_recycled"] == null)
				m_types[recycleObject.type+"_recycled"] = new Vector.<gtObject>();
					
			m_types[recycleObject.type+"_recycled"].push(recycleObject);
		}
		
		public static function Destroy(deadObject:Object)
		{
			if (deadObject.m_recycle)
			{
				Recycle(deadObject);
				deadObject.Reset();
				deadObject.m_clean = true;
			}
			else
				deadObject.Destructor();
		
			m_types[deadObject.type].splice(m_types[deadObject.type].indexOf(deadObject),1);
		}
	}
}