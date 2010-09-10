// gtCell.as
package GameTheater.gtObjects
{
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psTools.*;

	public class gtCell
	{ 
		public var m_grid:gtGameObject;
		public var m_tile:gtGameObject = null;
		
		public var m_loc:psVec2;
		public var m_up_left;
		public var m_up;
		public var m_up_right;
		public var m_left;
		public var m_right;
		public var m_down_left;
		public var m_down;
		public var m_down_right;
		
		public function gtCell(g,x = 0,y = 0)
		{
			m_grid = g;
			m_loc = new psVec2(x,y);
			m_tile = null;
		}
		
		public function Link()
		{
			m_up_left = m_grid.grid.GetCell(m_loc.x-1,m_loc.y-1);
			m_up = m_grid.grid.GetCell(m_loc.x,m_loc.y-1);
			m_up_right = m_grid.grid.GetCell(m_loc.x+1,m_loc.y-1);
			m_left = m_grid.grid.GetCell(m_loc.x-1,m_loc.y);
			m_right = m_grid.grid.GetCell(m_loc.x+1,m_loc.y);
			m_down_left = m_grid.grid.GetCell(m_loc.x-1,m_loc.y+1);
			m_down = m_grid.grid.GetCell(m_loc.x,m_loc.y+1);
			m_down_right = m_grid.grid.GetCell(m_loc.x+1,m_loc.y+1);
		}
		
		public function Load(t)
		{
			m_tile = gt.GO(gtTileB);
			m_tile.AddBehavior(t);
			m_tile.actor.Attach(m_grid);
			m_tile.tile.LinkCell(this);
		}
		
		public function Destroy()
		{
			m_tile.Destroy();
			m_tile = null;
			m_grid = null;
			m_up_left = null;
			m_up = null;
			m_up_right = null;
			m_left = null;
			m_right = null;
			m_down_left = null;
			m_down = null;
			m_down_right = null;
		}
  	}
}