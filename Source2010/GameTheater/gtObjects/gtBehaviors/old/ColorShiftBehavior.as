
// ColorShiftBehavior.as 
package GameTheater
{
	import GameTheater.*;
	import PinStriper.psTools.*;
	
	public class ColorShiftBehavior extends Behavior
	{
		public function ColorShiftBehavior()
		{
			
		}
		
		public override function Init(o:Object)
		{
			super.Init(o);
			
		}
		
		public override function Do(o:Object)
		{
			super.Do(o);
			
			var temp = o.transform.colorTransform;
			
			temp.redMultiplier += 0.01;
			if (temp.redMultiplier > 2)
				temp.redMultiplier = 0;
				
			/*temp.redOffset+=10;
			if (temp.redOffset > 255)
				temp.redOffset = -255;
			temp.blueOffset+=10;
			if (temp.blueOffset > 255)
				temp.blueOffset = -255;
			temp.greenOffset+=10;
			if (temp.greenOffset > 255)
				temp.greenOffset = -255;*/
			o.transform.colorTransform = temp;
		}
	}
}