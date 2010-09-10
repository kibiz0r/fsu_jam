//gtState
package GameTheater.gtObjects
{
	import flash.events.*;
	import GameTheater.gtSystems.*;
	import PinStriper.psSystems.*;
	
	public dynamic class gtLink
	{
		public var m_name:String;
		public var m_gameObject:gtGameObject = null;
		
		private var _parent:gtGameObject = null;
		public var _children:Array = new Array();

		public function gtLink(n:String,go:gtGameObject)
		{
			m_name = n;
			m_gameObject = go;
		}
		
		public function Clear()
		{
			while (_children.length > 0)
			{
				_children[0].parent = null;
			}
			parent = null;
		}
		
		public function Destroy()
		{
			Clear();
			m_gameObject = null;
		}
		
		public function addChild(c)
		{
			if (c.link["m_name"].parent != null)
			{
				c.link["m_name"].parent.link["m_name"].removeChild(c);
			}
			c.link["m_name"].parent = m_gameObject;
		}
		
		public function removeChild(c)
		{
			if (c.link["m_name"].parent == m_gameObject)
				c.link["m_name"].parent = null;
			else
				trace("child is not parented with type " + m_name);
		}
		
		public function get parent()
		{
			return _parent;
		}
		
		public function set parent(p)
		{
			if (_parent != null)
			{
				if (_parent == p)
				{
					trace("already the parent of type " + m_name);
					return;
				}
				
				var index = _parent.link[m_name].children.indexOf(m_gameObject,0);
				if (index == -1)
				{
					trace("something broke child is not parented with type " + m_name);
					return null;
				}
				else
				{
					_parent.link[m_name].children.splice(index,1)[0];
				}
			}
			
			_parent = p;
			if (_parent != null)
			{
				_parent.link[m_name].children.push(m_gameObject);
			}
		}
		
		public function get children()
		{
			return _children;
		}
		
		public function get siblings()
		{
			if (_parent == null)
				return null;
			else
				return _parent.link[m_name].children;
		}
	}
}