// psWnd.as 
package PinStriper.psObjects
{
	import flash.display.MovieClip;
	
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;
	
	public class psWnd extends MovieClip
	{	
		public var m_frame;
		public var m_header;
		public var m_frame;
		
	
		public function psWnd()
		{
			addEventListener( "enterFrame",this.Update);
		}
		public function Update(e:Event):void
		{
			
		}
	}
}