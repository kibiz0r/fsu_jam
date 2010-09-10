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
	
	import org.rje.glaze.engine.space.BruteForceSpace;
	
	public class glazeSpaceBehavior extends Behavior
	{
		public function glazeSpaceBehavior()
		{
			
		}
		
		public override function Init(o:Object)
		{
			o.m_space = new BruteForceSpace(30,90, null);
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);   
			o.m_space.step();
		}
		
		public override function Destroy(o:Object)
		{
			o.m_space = null;
			gtLog.Add("Cleaning up a space everything better already be cleaned up");
			trace("Cleaning up a space everything better already be cleaned up");
		}
	}
}