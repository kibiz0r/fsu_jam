// gt.as 
package GameTheater.gtTools
{
	import GameTheater.gtSystems.*;
	import GameTheater.gtObjects.*;
	import flash.utils.*;

	public class gt
	{
		public static function sNew(o:String)
		{
			var type = getDefinitionByName(o) as Class;
			return new type();
		}
		
		public static function sNewT(o:String)
		{
			return getDefinitionByName(o);
		}
		
		public static function New(o:Class,b:Class = null)
		{
			var go =  gtObjects.Create(o);
			if (b != null)
			{
				go.AddBehavior(b);
			}
			return go;
		}

		public static function GO(b:Class = null)
		{
			var go = gtObjects.Create(gtGameObject);
			if (b != null)
			{
				go.AddBehavior(b);
			}
			return go;
		}
	}
}