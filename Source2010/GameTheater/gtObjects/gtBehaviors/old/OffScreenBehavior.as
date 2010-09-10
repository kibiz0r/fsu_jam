// OffScreenBehavior.as 
package GameTheater.gtObjects.gtBehaviors
{
	import GameTheater.*;
	import PinStriper.psSystems.*;
	
	public class OffScreenBehavior extends Behavior
	{
		public function OffScreenBehavior()
		{
			
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			
			if (o.x > psEasel.m_originalWidth*0.5 + 30)
				o.Kill();
			if (o.x < -psEasel.m_originalWidth*0.5 - 30)
				o.Kill();
			if (o.y > psEasel.m_originalHeight*0.5 + 30)
				o.Kill();
			if (o.y < -psEasel.m_originalHeight*0.5 - 30)
				o.Kill();
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}