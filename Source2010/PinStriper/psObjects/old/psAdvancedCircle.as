package PinStriper.psObjects
{
	import flash.display.*;
	import flash.geom.*;
	import PinStriper.psTools.*;
	
	public class psAdvancedCircle extends Sprite
	{
		public var m_heightData:Array;
		
		public var m_colors:Array;
		public var m_alphas:Array;
		public var m_ratios:Array;
		
		public var m_fillType:String = GradientType.RADIAL;
		public var m_spreadMethos:String = SpreadMethod.PAD;
		
		public var m_gradMatrix:Matrix;
		
		public var m_gradAmount:Number = 1.0;
		public var m_gradRadius:Number = 0;
		
		public var m_strokeWidth:Number = 0;
		public var m_strokeColor:Number = psColor.FLORA_6;
		
		public function psAdvancedCircle()
		{
			m_heightData = new Array();
			m_colors = new Array();
			m_alphas = new Array();
			m_ratios = new Array();
			
			m_gradMatrix = new Matrix();
		}
		
		public function Render()
		{
			m_gradMatrix.createGradientBox(m_gradRadius*2*m_gradAmount, m_gradRadius*2*m_gradAmount, 0, -m_gradRadius*m_gradAmount, -m_gradRadius*m_gradAmount);
		
			this.graphics.clear();
			
			if (m_strokeWidth > 0)
				this.graphics.lineStyle(m_strokeWidth,m_strokeColor);
			
			this.graphics.beginGradientFill(m_fillType, m_colors, m_alphas, m_ratios, m_gradMatrix, m_spreadMethos);  
						
			var angleDelta = (360/m_heightData.length);
			
			var angle = -angleDelta;
			var rx, ry, ax, ay;
			
			ax = Math.cos(angle % 360 * Math.PI / 180) * m_heightData[m_heightData.length-1];
			ay = Math.sin(angle % 360 * Math.PI / 180) * m_heightData[m_heightData.length-1];
			this.graphics.moveTo(ax, ay);
			
			for (var i = 0; i < m_heightData.length; i++) 
			{
				angle += angleDelta;
				
				ax = Math.cos(angle % 360 * Math.PI / 180) * m_heightData[i];
				ay = Math.sin(angle % 360 * Math.PI / 180) * m_heightData[i];
				this.graphics.lineTo(ax, ay);
			}
			
			this.graphics.endFill();
		}
	}
}