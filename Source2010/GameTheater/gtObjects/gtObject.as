// gtObject.as 
package GameTheater.gtObjects
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import GameTheater.gtObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	
	public dynamic class gtObject extends MovieClip
	{
		public function gtObject()
		{
			Enable();
		}
		
		// Properties
		private var m_type:String = "";
		private var m_parentType:String = "";
		
		public var m_recycle:Boolean = false;
		public var m_clean:Boolean = true;
		
		public var creator = null;
		public var owner = null;
		
		public function get type()
		{
			if (m_type == "")
			{
				m_type = getQualifiedClassName(this).split("::")[1];
				if (!m_type)
					m_type = getQualifiedClassName(this).split("::")[0];
			}
			return m_type;
		}
		
		public function get parentType()
		{
			if (m_parentType == "")
			{
				m_parentType = getQualifiedSuperclassName(this).split("::")[1];
				if (!m_parentType)
					m_parentType = getQualifiedSuperclassName(this).split("::")[0];
			}
			return m_parentType;
		}
		
		// Controls
		public function Enable()
		{
			gtObjects.Add(this);
			m_clean = false;
		}
		
		final public function Recycle()
		{
			m_recycle = true;
			Destroy();
		}
		
		public function Destroy()
		{
			owner = null;
			gtObjects.Destroy(this);
		}
		
		public function Reset()
		{
			owner = null;
			creator = null;
			m_clean = true;
			m_type = "";
			m_parentType = "";
		}
		
		public function Destructor()
		{
			owner = null;
			creator = null;
			m_clean = true;
			m_type = "";
			m_parentType = "";
		}
	}
}