// psColor.as 
package PinStriper.psTools
{
  public class psColor 
  { 
    
	public var r:Number = 0;
	public var g:Number = 0;
	public var b:Number = 0;
	public var a:Number = 1;
	
	public static const SPACE_0 = 0x000066;
	public static const SPACE_1 = 0x000C2F;
	public static const SPACE_2 = 0x121D93;
	public static const SPACE_3 = 0x0033D7;
	public static const SPACE_4 = 0x1262F9;
	public static const SPACE_5 = 0x0372F8;
	public static const SPACE_6 = 0x0A7CFF;
	
	public static const FLORA_1 = 0x548A3F;
	public static const FLORA_2 = 0x55A536;
	public static const FLORA_3 = 0x4AA140;
	public static const FLORA_5 = 0x519037;
	public static const FLORA_4 = 0x548A3F;
	public static const FLORA_6 = 0x0D4103;
	
	public static const TERRA_1 = 0x312B2B;
	public static const TERRA_2 = 0x56442C;
	public static const TERRA_3 = 0x47352B;
	public static const TERRA_5 = 0x3B2D22;
	public static const TERRA_4 = 0x4D4F41;
	public static const TERRA_6 = 0x211A14;
	
	public static const MANTLE_1 = 0x840000;
	public static const MANTLE_2 = 0xA90101;
	public static const MANTLE_3 = 0xD90202;
	public static const MANTLE_5 = 0xFD0909;
	public static const MANTLE_4 = 0xFC3A3A;
	public static const MANTLE_6 = 0xFD7979;
	
	public static const CORE_1 = 0xF88125;
	public static const CORE_2 = 0xFFBF37;
	public static const CORE_3 = 0xFAD137;
	public static const CORE_5 = 0xFFC239;
	public static const CORE_4 = 0xF9D893;
	public static const CORE_6 = 0xFEFEFE;
	
	public function psColor(red,green,blue,alpha)
	{ 
		r = red;
		g = green;
		b = blue;
		a = alpha;
	}
	
	public static function toHex(r,g,b)
	{
		return r << 16 | g << 8 | b;
	}
	
	public static function toHexf(r,g,b)
	{
		if (r < 0)
			r = 0;
		if (r > 1)
			r = 1;
		if (g < 0)
			g = 0;
		if (g > 1)
			g = 1;
		if (b < 0)
			b = 0;
		if (b > 1)
			b = 1;
		return (r*255) << 16 | (g*255) << 8 | (b*255);
	}
	
	public function Hex()	
	{
		var color = r << 16 | g << 8 | b;
		return color;
	}
	
  }
}