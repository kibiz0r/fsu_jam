// WrapScreenBehavior.as 
package GameTheater
{
	import GameTheater.*;
	import PinStriper.psTools.*;
	
	public class WrapScreenBehavior extends Behavior
	{
		public function WrapScreenBehavior()
		{
			m_orderWeight = 1;
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			if (o.x > o.stage.stageWidth + 30)
				o.x = -30;
			if (o.x < -30)
				o.x = o.stage.stageWidth + 30;
			if (o.y > o.stage.stageHeight + 30)
				o.y = -30;
			if (o.y < -30)
				o.y = o.stage.stageHeight + 30;
		}
		
		public override function Destroy(o:Object)
		{
		}
	}
}