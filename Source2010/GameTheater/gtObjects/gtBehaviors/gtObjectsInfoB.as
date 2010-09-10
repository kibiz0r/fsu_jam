// FPSBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	import flash.text.*;
	import flash.ui.*;
	
	public dynamic class gtObjectsInfoB extends gtBehavior
	{
		public function gtObjectsInfoB()
		{
			m_name = "objInfo";
			m_orderWeight = 0.9;
		}
		
		public override function Awake()
		{
			gameObject.m_objInfo = new TextField();
			gameObject.m_objInfo.autoSize = TextFieldAutoSize.LEFT;
			gameObject.m_objInfo.selectable = false;
			gameObject.m_objInfo.text = "0"; 
			gameObject.m_objInfo.x = 0;
			gameObject.m_objInfo.y = psEasel.that.height - 17;
			var format:TextFormat = new TextFormat();
            //format.font = "Verdana";
            format.color = 0xFFFFFF;
            //format.size = 10;
            gameObject.m_objInfo.defaultTextFormat = format;
			
			psEasel.AddCanvas("ObjectsInfo").addChild(gameObject.m_objInfo);
			gameObject.states.Add("ObjInfoUpdate",ObjInfoUpdate,"OBJ_INFO").Update();
		}
		
		public override function Start()
		{
			gameObject.states.Activate("ObjInfoUpdate");
		}
		
		public function ObjInfoUpdate(setting:int)
		{
			if (setting == gtState.UPDATE)
			{
				gameObject.m_objInfo.x = -(psEasel.that.m_width/2);
				gameObject.m_objInfo.y = -(psEasel.that.m_height/2);
				gameObject.m_objInfo.text = gtObjects.ReportString();
			}
		}
		
		public override function Destructor()
		{
		}
	}
}