// CollisionBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import flash.events.Event;
	import flash.events.*;
	
	import GameTheater.gtObjects.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	import flash.geom.*;
	
	import org.rje.glaze.engine.collision.shapes.Circle;
	import org.rje.glaze.engine.collision.shapes.Polygon;
	import org.rje.glaze.engine.dynamics.Material;
	import org.rje.glaze.engine.dynamics.RigidBody;
	import org.rje.glaze.engine.math.Vector2D;
	
	public class glazeObjectBehavior extends Behavior
	{
		public function glazeObjectBehavior()
		{
			//m_looping = false;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);       // mass // moment of inertia
			o.m_body = new RigidBody(RigidBody.DYNAMIC_BODY,1);
			o.m_body.p.setTo(o.x,o.y);
									//radius					// elasticity //friction // density
			o.m_shape = new Circle(o.m_radius, Vector2D.zeroVect, new Material(0, 0.1, 1));
			
			o.m_body.addShape(o.m_shape);
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);   
			//o.x = o.m_body.p.x;
			//o.y = o.m_body.p.y;
			if (o.m_shape.body == null)
				trace(o);
		}
		
		public override function Destroy(o:Object)
		{
			super.Destroy(o);
			
			if (o.m_soup != null)
				o.m_soup.m_space.removeRigidBody(o.m_body);
			else
				trace("what");
			//o.m_body.removeShape(o.m_shape);
			o.m_body = null;
			o.m_shape = null;
		}
	}
}