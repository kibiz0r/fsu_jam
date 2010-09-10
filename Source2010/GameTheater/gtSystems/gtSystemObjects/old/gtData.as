// gtData.as 
package GameTheater.gtSystems.gtSystemObjects
{	
	public class gtData
	{ 
		public var m_name:String;
		public var m_xml:String;
		
		public var m_attributes:Array;
		public var m_children:Object;
		public var m_types:Array;
		public var m_atypes:Array;
	
		public function gtData()
		{ 
			m_name = new String();
			m_xml = new String();
			
			m_attributes = new Array();
			m_children = new Object();
			m_types = new Array();
			m_atypes = new Array();
		}
	}
}