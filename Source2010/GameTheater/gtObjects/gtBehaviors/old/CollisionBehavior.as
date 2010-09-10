// CollisionBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	import flash.geom.*;
	
	import org.cove.ape.*;
	
	public class CollisionBehavior extends Behavior
	{
		public function CollisionBehavior()
		{
			m_orderWeight = 0.9;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			o.m_ColData = new Group();
			APEngine.addGroup(o.m_ColData);
			
			var p = o.localToGlobal(new Point(0,0));
			o.m_ColCircle = new CircleParticle(p.x,p.y,o.m_radius);
			o.m_ColCircle.setStyle(1, 0x334433, 1, 0x3366aa);
			o.m_ColCircle.collisionCB = o.ResolveCollision2;
			o.m_ColCircle.dataLink = o;
			o.m_ColCircle.radius = o.m_radius;
			o.m_ColData.addParticle(o.m_ColCircle);
			o.m_ColCircle.visible = false;
			
			gtCollisionManager.GetInstance().Link(o);
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			
			/*if (!o.CheckState("Alive"))
				o.m_ColCircle.collidable = false;
			else
			{*/
				//o.m_ColCircle.collidable = true;
				
				//var p = o.localToGlobal(new Point(0,0))
				//o.m_ColCircle.px = p.x;
				//o.m_ColCircle.py = p.y;
				var p = o.parent.globalToLocal(new Point(o.m_ColCircle.px,o.m_ColCircle.py))
				o.x = p.x;
				o.y = p.y;
			//}
		}
		
		public override function Destroy(o:Object)
		{
			//gtCollisionManager.GetInstance().UnLink(o);
			APEngine.removeGroup(o.m_ColData);
		}
	}
}