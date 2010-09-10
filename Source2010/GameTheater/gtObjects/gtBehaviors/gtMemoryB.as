// MemoryBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.*;
	
	public dynamic class gtMemoryB extends gtBehavior
	{
		public function gtMemoryB()
		{
			m_name = "memory";
			m_orderWeight = 0.9;
		}
		
		public override function Awake()
		{
			gameObject.m_memory = new TextField();
			gameObject.m_memory.autoSize = TextFieldAutoSize.LEFT;
			gameObject.m_memory.selectable = false;
			gameObject.m_memory.text = "0"; 
			gameObject.m_memory.x = 0;
			gameObject.m_memory.y = psEasel.that.height - 36;
			var format = new TextFormat();
            format.color = 0x0066FF;
			gameObject.m_memory.defaultTextFormat = format;
			psEasel.AddCanvas("MEM").addChild(gameObject.m_memory);
			
			gameObject.states.Add("MemoryUpdate",MemoryUpdate,"MEM").Update();
		}
		
		public override function Start()
		{
			gameObject.states.Activate("MemoryUpdate");
		}
		
		public function MemoryUpdate(setting:int)
		{
			if (setting == gtState.UPDATE)
			{
				gameObject.m_memory.x = -(psEasel.that.m_width/2);
				gameObject.m_memory.y = (psEasel.that.m_height/2) - 36;
				gameObject.m_memory.text = int(((System.totalMemory-System.freeMemory)*0.001)).toString()+"K";
			}
		}
		
		public override function Destructor()
		{
		}
	}
}