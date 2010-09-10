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
	import org.rje.glaze.engine.dynamics.Material;
	import org.rje.glaze.engine.dynamics.RigidBody;
	import org.rje.glaze.engine.math.Vector2D;
	
	public class glazeJointBehavior extends Behavior
	{
		public function glazeJointBehavior()
		{
			//m_looping = false;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);                                 // mass // moment of inertia
			o.m_body = new RigidBody(RigidBody.DYNAMIC_BODY,1,500);
			o.m_body.p.setTo(o.x,o.y);
									//radius					// elasticity //friction // density
			o.m_shape = new Circle(o.m_radius, Vector2D.zeroVect, new Material(0.2, 0, 1));
			o.m_body.addShape(o.m_shape);
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);   
			o.x = o.m_body.p.x;
			o.y = o.m_body.p.y;
		}
		
		public override function Destroy(o:Object)
		{
			super.Destroy(o);  
			o.m_body.removeShape(o.m_shape);
			o.m_body = null;
			o.m_shape = null;
		}
	}
}