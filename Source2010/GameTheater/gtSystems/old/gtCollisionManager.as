// gtCollisionManager.as 
package GameTheater.gtSystems
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class gtCollisionManager
	{
		public static var m_instance = null;
		
		public var m_collisionChecks:Array;
		
		public function gtCollisionManager()
		{
			//APEngine.init(1/4);
			//APEngine.container = psEasel.AddCanvas("Collision");
			//m_collisionChecks = new Array();
		}
		
		public static function GetInstance()
		{
			if(m_instance == null)
				m_instance = new gtCollisionManager();

			return m_instance;
		}
		
		public static function DeleteInstance()
		{
			m_instance = null;
		}		
		
		/*public function Add(type1,type2)
		{
			var t1:Array = LookupType(type1);
			var t2:Array = LookupType(type2);
			
			if (type1 == type2)
			{
				t1.push(type2);
			}
			else
			{
				t1.push(type2);
				t2.push(type1);
			}
		}*/
		
		/*public function LookupType(type:String):Array
		{
			if (m_collisionChecks[type])
			{
				return m_collisionChecks[type];
			}
			
			var newType:Array = new Array();
			m_collisionChecks[type] = newType;
			return newType;
		}*/
		
		public function Update(deltaT:Number)
		{
			//APEngine.step();
			//APEngine.paint();
			/*for (var i:* in m_collisionChecks)
			{
				var t1:Array = m_ObjFac.LookupType(i);
				var t2:Array = new Array();
				for (var j:int = 0; j < m_collisionChecks[i].length; j++)
				{
					t2 = t2.concat(m_ObjFac.LookupType(m_collisionChecks[i][j]));
				}
				for (var k:int = 0; k < t1.length; k++)
				{
					
					for (var l:int = 0; l < t2.length; l++)
					{
						
						if (t1[k] != t2[l] && t1[k].TestCollision(t2[l]))
						{
							t1[k].ResolveCollision(t2[l]);
							t2[l].ResolveCollision(t1[k]);
						}
					}
				}
			}*/
		}
		
		/*public function Link(o)
		{
			if (!m_collisionChecks[o.m_type])
				return;
				
			var t1:Array = new Array();
			for (var i:int = 0; i < m_collisionChecks[o.m_type].length; i++)
			{
				t1.push(gtObjects.GetInstance().LookupType(m_collisionChecks[o.m_type][i]));
			}
			
			for (i = 0; i < t1.length; i++)
			{
				for (var j:int = 0; j < t1[i].length; j++)
				{
					if (o != t1[i][j])
					{
						o.AddCollidable(t1[i][j]);
						//t1[i].AddCollidable(o);
					}
				}
				
			}
		}
		
		public function UnLink(o)
		{
			if (!m_collisionChecks[o.m_type])
				return;
				
			var t1:Array = new Array();
			for (var i:int = 0; i < m_collisionChecks[o.m_type].length; i++)
			{
				t1 = t1.concat(gtObjects.GetInstance().LookupType(m_collisionChecks[o.m_type][i]));
			}
			
			for (i = 0; i < t1.length; i++)
			{
				if (o != t1[i])
				{
					o.RemoveCollidable(t1[i]);
					//t1[i].RemoveCollidable(o);
				}
			}
		}*/
	}
}