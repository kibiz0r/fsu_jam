// gtLog.as 
package GameTheater.gtSystems
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.text.*;
	import flash.events.Event;
    import flash.events.KeyboardEvent;
	import flash.ui.*;
	
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class gtLog extends MovieClip
	{
		public static var m_instance = null;
		public var m_inputBox:TextField;
		public var m_log:TextField;
		public var m_open:Boolean = true;
		public var m_last:String = "";
		
		public var m_ComMan:gtCommandManager;
		
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new gtLog;

			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}		
		
		public function gtLog()
		{
			m_log = new TextField();
			m_log.border = true;
			m_log.background = true;
			m_log.multiline = true;
			m_log.wordWrap = false;
			m_log.selectable = true;
			m_log.type = TextFieldType.DYNAMIC;
			m_log.text = ""; 
			m_log.x = -psEasel.that.m_width/2;
			m_log.y = -psEasel.that.m_height/2;
			m_log.width = psEasel.that.m_width-1;
			m_log.height = 95;
			addChild(m_log);
			
			m_inputBox = new TextField();
			m_inputBox.border = true;
			m_inputBox.background = true;
			m_inputBox.multiline = false;
			m_inputBox.wordWrap = false;
			m_inputBox.selectable = true;
			m_inputBox.type = TextFieldType.INPUT;
			m_inputBox.text = ""; 
			m_inputBox.x = -psEasel.that.m_width/2;
			m_inputBox.y = -(psEasel.that.m_height/2)+95;
			m_inputBox.width = psEasel.that.m_width-1;
			m_inputBox.height = 20;
			addChild(m_inputBox);
			
			Close();
			
			m_ComMan = gtCommandManager.GetInstance();
		}
		
		public function Resize(e:Event):void
		{
			m_log.x = -psEasel.that.m_width/2;
			m_log.y = -psEasel.that.m_height/2;
			m_log.width = psEasel.that.m_width-1;
			
			m_inputBox.x = -psEasel.that.m_width/2;
			m_inputBox.y = -(psEasel.that.m_height/2)+95;
			m_inputBox.width = psEasel.that.m_width-1;
			
		}  
		
		public function KeyListener(event:KeyboardEvent):void 
		{
			if (event.keyCode == Keyboard.ENTER)
			{
				if (m_inputBox.text != "")
				{
					Add(m_inputBox.text);
					Add(m_ComMan.PerformCommand(m_inputBox.text));
					m_last = m_inputBox.text;	
					m_inputBox.text = "";
				}
			}
			if (event.keyCode == Keyboard.UP)
			{
				m_inputBox.text = m_last;
			}
			else if (event.keyCode == 192)
			{
				if (m_open)
					Close();
				else
					Open();	
			}
		}
		
		public function Open()
		{
			m_log.visible = true;
			m_inputBox.visible = true;
			stage.focus = m_inputBox;
			m_open = true;
			m_inputBox.text = "";
		}
		
		public function Close()
		{
			m_log.visible = false;
			m_inputBox.visible = false;
			m_open = false;
		}
		
		public static function Add(txt:String)
		{
			if (txt.length > 0)
			{
				GetInstance().m_log.appendText(txt + "\n");
				GetInstance().m_log.scrollV = GetInstance().m_log.maxScrollV;
			}
		}
	}
}