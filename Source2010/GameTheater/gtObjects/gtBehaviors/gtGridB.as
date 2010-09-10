// gtGridB.as 
package GameTheater.gtObjects.gtBehaviors
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import fl.motion.easing.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public dynamic class gtGridB extends gtBehavior
	{ 
		public var m_width:int = 0;
		public var m_length:int = 0;
		
		public var m_cells:Vector.<Vector.<gtCell>> = null;
		
		public function gtGridB()
		{
			m_name = "grid";
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Reset()
		{
			for (var row = 0; row < m_length; row++)
			{
				for (var col = 0; col < m_width; col++)
				{
					m_cells[row][col].Destroy();
					m_cells[row][col] = null;
				}
				m_cells[row] = null;
			}
			m_cells = null;
			m_width = 0;
			m_length = 0;
		}
		
		public override function Destructor()
		{
			for (var row = 0; row < m_length; row++)
			{
				for (var col = 0; col < m_width; col++)
				{
					m_cells[row][col].Destroy();
					m_cells[row][col] = null;
				}
				m_cells[row] = null;
			}
			m_cells = null;
			m_width = 0;
			m_length = 0;
		}
		
		public function GetCell(c:int,r:int)
		{
			if (c >= 0 && c < m_width && r >= 0 && r < m_length)
			{
				if (m_cells[r][c])
					return m_cells[r][c];
			}
			return null;
		}
		
		public function New(rows:Number, columns:Number, t)
		{
			m_cells = new Vector.<Vector.<gtCell>>();
			
			m_width = rows;
			m_length = columns;
			
			for (var row = 0; row < m_length; row++)
			{
				m_cells.push(new Vector.<gtCell>());
				for (var col = 0; col < m_width; col++)
				{
					m_cells[row].push(new gtCell(gameObject,col,row));
				}
			}
			for (row = 0; row < m_length; row++)
			{
				for (col = 0; col < m_width; col++)
				{
					m_cells[row][col].Link();
					m_cells[row][col].Load(t);
				}
			}
		}
	}
}