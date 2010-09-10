// gtTileB.as
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;

	public dynamic class gtTileB extends gtBehavior
	{ 
		public var m_cell:gtCell;
		
		public function gtTileB()
		{
			m_name = "tile";
		}
		
		public function LinkCell(c)
		{
			m_cell = c;
			SendMessage("LinkCell",c);
		}
  	}
}