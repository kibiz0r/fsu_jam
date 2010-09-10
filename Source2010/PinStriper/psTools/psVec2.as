// psVec2.as 
package PinStriper.psTools
{
	public class psVec2 
	{
		public var x:Number;
		public var y:Number;
		
		public function psVec2(x = 0,y = 0)
		{
			this.x = x;
			this.y = y;
		}
		
		public function str()
		{
			return ( "(" + x + "," + y + ")" )
		}
		
		public function clone()
		{
			var v = new psVec2(x, y);
			return v;
		}
		
		public function plus(v2)
		{
			var v = new psVec2( x + v2.x, y + v2.y)
			return v;
		}
		
		public function minus(v2)
		{
			var v = new psVec2( x - v2.x, y - v2.y)
			return v;
		}
		
		public function pluseq(v2)
		{
			x += v2.x;
			y += v2.y;
		}
		
		public function minuseq(v2)
		{
			x -= v2.x;
			y -= v2.y;
		}
		
		public function dir()
		{
			var v = clone();
			v.normalize();
			return v;
		}
		
		public function proj(v2)
		{
			var den = v2.dot(v2);
			var v;
			if( den == 0)
			{
				trace("WARNING! proj() was given a zero-length projection vector!");
				v = clone();//not sure how to gracefully recover but, hopefully this will be okay
			}
			else
			{
				v = v2.clone();
				v.mult(this.dot(v2)/den);
			}
			
			return v;
		}
		
		public function projLen(v2)
		{
		
			var den = v2.dot(v2);
			if( den == 0)
			{
				trace("WARNING! projLen() was given a zero-length projection vector!");
				return 0;
			}
			else
			{
				return Math.abs(this.dot(v2)/den);
			}
			
		}
		
		public function dot(v2)
		{
			return ((x * v2.x) + (y * v2.y));
		}
		
		public function cross(v2)
		{
			return ((x * v2.y) - (y * v2.x) );
		}
		
		public function len()
		{
			return ( Math.sqrt((x*x) + (y*y)) );
		}
		
		public function lenSqr()
		{
			return ( (x*x) + (y*y) );
		}
		
		public function copy(v2)
		{
			x = v2.x;
			y = v2.y;
		}
		
		public function scale(s)
		{
			x *= s;
			y *= s;
		}
		
		public function normalize()
		{
			var l = this.len();
			if( l != 0)
			{
				x *= (1/l);
				y *= (1/l);	
			}
		}
  	}
}

