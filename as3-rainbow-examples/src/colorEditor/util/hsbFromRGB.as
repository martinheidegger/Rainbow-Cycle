package colorEditor.util {
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public function hsbFromRGB( r: Number, g: Number, b: Number ): HSB {
		
		// Ported from http://www.cs.rit.edu/~ncs/color/t_convert.html
		var min: Number = Math.min( r, g, b );
		var max: Number = Math.max( r, g, b );
		var hsb: HSB = new HSB();
		hsb.b = max / 255.0;
		
		if( max == 0 ) {
			hsb.s = 0.0;
			hsb.h = -1.0;
		} else {
			var delta: Number = max - min;
			hsb.s = delta / max;
		
			if( r == max )
				hsb.h = ( g - b ) / delta; // between yellow & magenta
			else if( g == max )
				hsb.h = 2.0 + ( b - r ) / delta; // between cyan & yellow
			else
				hsb.h = 4.0 + ( r - g ) / delta; // between magenta & cyan
			
			hsb.h *= 60.0; // degrees
			if( hsb.h < 0 )
				hsb.h += 360;
		}
		
		return hsb;
	}
}
