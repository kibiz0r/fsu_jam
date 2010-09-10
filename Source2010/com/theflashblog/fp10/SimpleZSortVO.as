package com.theflashblog.fp10 {
	import flash.display.DisplayObject;			

	/**
	 * @author Ralph Hauwert / UnitZeroOne
	 */
	public class SimpleZSortVO
	{
		public var object : DisplayObject;
		public var screenZ:Number;
		public var screenY:Number;
		
		public function SimpleZSortVO(object : DisplayObject, screenZ:Number, screenY:Number){
			this.object = object;
			this.screenZ = screenZ;
			this.screenY = screenY;
		}
	}
}
