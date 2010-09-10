package PinStriper.psObjects
{
	import flash.display.*;
	import flash.geom.*;
	import PinStriper.psTools.*;
	
	public class psBox extends Sprite
	{
		public var m_width:Number = 0;
		public var m_height:Number = 0;
		
		public var m_colors:Array = new Array();
		public var m_alphas:Array = new Array();
		public var m_ratios:Array = new Array();
		
		public var m_fillType:String = GradientType.LINEAR;
		public var m_spreadMethos:String = SpreadMethod.PAD;
		
		public var m_gradMatrix:Matrix;
		
		public var m_gradAmount:Number = 1.0;
		
		public function psBox(X,Y)
		{
			m_width = X;
			m_height = Y;
			
			m_gradMatrix = new Matrix();
		}
		
		public function Render()
		{
			m_gradMatrix.createGradientBox(m_width, m_height, Math.PI/180 * 90, 0, 0);
		
			this.graphics.clear();
			this.graphics.beginGradientFill(m_fillType, m_colors, m_alphas, m_ratios, m_gradMatrix, m_spreadMethos);  
			this.graphics.drawRect(0, 0, m_width, m_height);
			this.graphics.endFill();
		}
	}
}