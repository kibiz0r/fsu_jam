package PinStriper.psObjects
{
	import flash.display.*;
	import flash.events.*;
	import fl.containers.*;
	
	public class main extends MovieClip {
		
		
		public function main() 
		{
			addEventListener(Event.ADDED_TO_STAGE,Added);
		}
		
		public function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,Added);
			trace("test");
			var m_test = new test();
			m_test.x = 250;
			m_test.y = 250;
			//tabEnabled = false;
			//tabChildren = true;
			
			//m_scroll.tabChildren = true;
			
			//Sprite(m_scroll.content.parent).tabEnabled = false;
			//Sprite(m_scroll.content.parent).tabChildren = true;
			
			//MovieClip(m_scroll.content).tabEnabled = false;
			//MovieClip(m_scroll.content).tabChildren = true;
			var m_scroll = new ScrollPane();
			addChild(m_scroll);
			Sprite(m_scroll.contentClip).addChild(m_test);
			//m_test.tabEnabled = false;
			//m_test.tabChildren = true;
			//m_test.m_test1.tabEnabled = true;
			//m_test.m_test1.tabChildren = true;
			//m_test.m_test2.tabEnabled = true;
			//m_test.m_test2.tabChildren = true;
			InteractiveObject(m_test.m_test1).tabIndex = 1;
			InteractiveObject(m_test.m_test2).tabIndex = 2;
			
			stage.focus = m_test.m_test1.getChildAt(1);
			
			//m_scroll.tabEnabled = false;
			
			var p = m_test.m_test1.getChildAt(1);
			while ( p != null)
			{
				trace(p,p.tabChildren,p.tabEnabled,p.tabIndex);
				p = p.parent;
			}
			
		}
	}
	
}
