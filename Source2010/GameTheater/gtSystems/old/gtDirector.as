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
	
	public dynamic class Director
	{
		public static var m_instance = null;
		public var m_ObjFac:ObjectFactory;
		public var m_characters:Array;
		
		public function Director()
		{
			m_ObjFac = ObjectFactory.GetInstance();
			m_characters = new Array();
		}
		
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new Director;

			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}
		
		public function HasCharacter(id:String)
		{
			return (m_characters[id] != null);
		}
		
		public function NewCharacter(id:String,t:String = "NPC")
		{
			var char = new gtCharacter();
			char.m_name = id;
			
			if (t == "NPC")
			{
				QuestManager.GetInstance().AddNPC(char);
			}
			else if (t == "PLAYER")
			{
				psEasel.m_root.GetCamera().Follow(char);
				QuestManager.GetInstance().AddQuester("player",char);
				char.m_active = true;
				char.m_player = true;
			}
			else if (t == "NET")
			{
				char.m_active = true;
			}
			
			m_characters[id] = char;
			return char;
		}
		
		public function PlaceCharacter(id,map,x,y)
		{
			var grid = World.GetInstance().GetMap(map);
			grid.AddCharacter(m_characters[id].m_name,m_characters[id],x,y);
			psLog.Add("Character Added: " + id + " to " + map + " at " + x + "," + y);
		}
		
	}
}