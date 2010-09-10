// psMathHelper.as 
package GameTheater.gtTools
{
	import PinStriper.psTools.psVec2;
	
	public class gtMathHelper
	{
		/*public function detect() : Boolean
		{
		   
		    //difference vector of the 2 circles’ positions
		    var cDiff:Vector = c2.position.getDifference( c1.position );
		   
		    var c:Number = cDiff.dot( cDiff ) - ( c1.radius + c2.radius ) * ( c1.radius + c2.radius );
		    if( c <0 )
		    {
		  	  	//initial overlap condition- return with time 0
		  	  	t = 0;
		  	  	return true;
		    }
		   
		    //difference between circles’ velocities
		    var vDiff:Vector = c2.velocity.getDifference( c1.velocity );
		     
		    var a:Number = vDiff.dot( vDiff );
		    if( a <Collision.OMEGA ) 
				return false; //circles not moving relative each other
		   
		    var b:Number = vDiff.dot( cDiff );
		    if( b>= 0 ) 
				return false; //circles moving apart
		   
		    var d:Number = b * b - a * c;
		    if( d <0 ) 
				return false; //no solution to the quadratic equation- circles don’t intersect
		   
		    //evaluate the time of collision
		    t = ( -b - Math.sqrt( d ) ) / a;
		    return t <= 1;   
		}*/


		
		public static function FastCollide(o1,o2):Boolean
		{
			    // Early Escape test: if the length of the movevec is less
				// than distance between the centers of these circles minus
				// their radii, there's no way they can hit.
				/*double dist = B.center.distance(A.center);
				double sumRadii = (B.radius + A.radius);
				dist -= sumRadii;
				if(movevec.Magnitude() < dist){
				  return false;
				}
			
				// Normalize the movevec
				Vector N = movevec.copy();
				N.normalize();
			
				// Find C, the vector from the center of the moving
				// circle A to the center of B
				Vector C = B.center.minus(A.center);
			
				// D = N . C = ||C|| * cos(angle between N and C)
				double D = N.dot(C);
			
				// Another early escape: Make sure that A is moving
				// towards B! If the dot product between the movevec and
				// B.center - A.center is less that or equal to 0,
				// A isn't isn't moving towards B
				if(D <= 0){
				  return false;
				}
			
				// Find the length of the vector C
				double lengthC = C.Magnitude();
			
				double F = (lengthC * lengthC) - (D * D);
			
				// Escape test: if the closest that A will get to B
				// is more than the sum of their radii, there's no
				// way they are going collide
				double sumRadiiSquared = sumRadii * sumRadii;
				if(F >= sumRadiiSquared){
				  return false;
				}
			
				// We now have F and sumRadii, two sides of a right triangle.
				// Use these to find the third side, sqrt(T)
				double T = sumRadiiSquared - F;
			
				// If there is no such right triangle with sides length of
				// sumRadii and sqrt(f), T will probably be less than 0.
				// Better to check now than perform a square root of a
				// negative number.
				if(T < 0){
				  return false;
				}
			
				// Therefore the distance the circle has to travel along
				// movevec is D - sqrt(T)
				double distance = D - sqrt(T);
			
				// Get the magnitude of the movement vector
				double mag = movevec.Magnitude();
			
				// Finally, make sure that the distance A has to move
				// to touch B is not greater than the magnitude of the
				// movement vector.
				if(mag < distance){
				  return false;
				}
			
				// Set the length of the movevec so that the circles will just
				// touch
				movevec.normalize();
				movevec.times(distance);
			*/
				return false;
				//return true; 
		}
			
		public static function CircleToCircle(o1,o2):Boolean
		{
			var xSqu:Number = o2.x - o1.x;
			var ySqu:Number = o2.y - o1.y;
			xSqu *= xSqu;
			ySqu *= ySqu;
			
			
			if (xSqu + ySqu < (o1.m_radius+o2.m_radius) * (o1.m_radius+o2.m_radius))
				return true;
			return false;
		}
		
		public static function HalfSpaceTest(o1,o2):Boolean
		{
			var P1:psVec2 = new psVec2(o2.x-o1.x,o2.y-o1.y);
			if (P1.dot(o1.m_direction.dir()) >= 0)
				return true;
			return false;
		}
		
		public static function RadiansToDegree(r):Number
		{
			return r*(180/Math.PI);
		}
		
		public static function DegreesToRadans(d):Number
		{
			return (d * Math.PI)/180;
		}
		
		public static function randRange(min:Number, max:Number):Number 
		{
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		
		public static function randString(size:Number):String
		{
			var s = new String();
			for (var i = 0; i < size; i++)
			{
				s += String.fromCharCode(randRange(97,122));
			}
			return s;
		}
			
	}
}