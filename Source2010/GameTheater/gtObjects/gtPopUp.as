//gtButton
package GameTheater.gtObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public dynamic class gtPopUp
	{
		public var m_name:String;
		public var m_gameObject:gtGameObject = null;
		public var m_popup = null;
		
		public var m_confirm:Boolean = false;
		public var m_cancel:Boolean = false;
		public var m_action1:Boolean = false;
		public var m_action2:Boolean = false;
		public var m_action3:Boolean = false;
		
		public function gtPopUp(n,pu,go)
		{
			m_name = n;
			m_popup = pu;
			m_gameObject = go;
			m_popup.creator = m_gameObject;
			m_popup.owner = this;
		}
		
		public function Destroy()
		{
			if (m_confirm)
				m_gameObject.ui.RemoveButton(m_name+"_confirm");
			if (m_cancel)
				m_gameObject.ui.RemoveButton(m_name+"_cancel");
			if (m_action1)
				m_gameObject.ui.RemoveButton(m_name+"_action1");
			if (m_action2)
				m_gameObject.ui.RemoveButton(m_name+"_action2");
			if (m_action3)
				m_gameObject.ui.RemoveButton(m_name+"_action3");
			
			m_popup.creator = null;
			m_popup.owner = null;
			m_popup = null;
			m_gameObject = null;
		}
		
		// Settings
		public function Confirm(b)
		{
			m_confirm = true;
			m_gameObject.ui.AddButton(m_name+"_confirm",b).Click();
			return this;
		}
		
		public function Action1(b)
		{
			m_action1 = true;
			m_gameObject.ui.AddButton(m_name+"_action1",b).Click().Hover(true);
			return this;
		}
		public function Action2(b)
		{
			m_action2 = true;
			m_gameObject.ui.AddButton(m_name+"_action2",b).Click().Hover(true);
			return this;
		}
		public function Action3(b)
		{
			m_action3 = true;
			m_gameObject.ui.AddButton(m_name+"_action3",b).Click().Hover(true);
			return this;
		}
		
		public function Cancel(b)
		{
			m_cancel = true;
			m_gameObject.ui.AddButton(m_name+"_cancel",b).Click();
			return this;
		}
	}
}