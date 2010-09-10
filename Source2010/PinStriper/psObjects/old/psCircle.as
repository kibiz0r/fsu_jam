package PinStriper.psObjects
{
	import flash.display.*;
	import flash.geom.*;
	import PinStriper.psTools.*;
	
	public class psCircle extends Sprite
	{
		public var m_radius:Number = 0;
		
		public var m_colors:Array;
		public var m_alphas:Array;
		public var m_ratios:Array;
		
		public var m_fillType:String = GradientType.RADIAL;
		public var m_spreadMethos:String = SpreadMethod.PAD;
		
		public var m_gradMatrix:Matrix;
		
		public var m_gradAmount:Number = 1.0;
		
		public function psCircle()
		{
			m_colors = new Array();
			m_alphas = new Array();
			m_ratios = new Array();
			
			m_gradMatrix = new Matrix();
		}
		
		public function Render()
		{
			m_gradMatrix.createGradientBox(m_radius*2*m_gradAmount, m_radius*2*m_gradAmount, 0, -m_radius*m_gradAmount, -m_radius*m_gradAmount);
		
			this.graphics.clear();
			this.graphics.beginGradientFill(m_fillType, m_colors, m_alphas, m_ratios, m_gradMatrix, m_spreadMethos);  
			this.graphics.drawCircle(0, 0, m_radius);
			this.graphics.endFill();
		}
	}
}