package at.leichtgewicht.color.util {
	
	/**
	 * Ported from:
	 * 
	 *   Author: Arah J. Leonard
	 *   Copyright 01AUG09
	 *   Distributed under the LGPL - http://www.gnu.org/copyleft/lesser.html
	 *   ALSO distributed under the The MIT License from the Open Source Initiative (OSI) - http://www.opensource.org/licenses/mit-license.php
	 *   You may use EITHER of these licenses to work with / distribute this source code.
	 *   Enjoy!
	 * 
	 * @author Martin Heidegger mh@leichtgewicht.at
	 * @see http://www.insanit.net/2009/08/01/
	 */
	public function RYBtoUint( ryb: uint ): uint {
		
		var r: Number = ( ryb & 0xFF0000 ) >> 16;
		var y: Number = ( ryb & 0xFF00 ) >> 8;
		var b: Number = ( ryb & 0xFF );
		
		// Remove the whiteness from the color.
		var w: Number = Math.min( r, y, b );
		r = r - w;
		y = y - w;
		b = b - w;
		
		var my: Number = Math.max( r, y, b );
		
		// Get the green out of the yellow and blue
		var g: Number = Math.min( y, b );
		y -= g;
		b -= g;
		
		b *= 2.0;
		g *= 2.0;
		
		// Redistribute the remaining yellow.
		r += y;
		g += y;
		
		// Normalize to values.
		var mg: Number = Math.max( r, g, b );
		
		if( mg > 0 ) {
			var n: Number = my / mg;
			r *= n;
			g *= n;
			b *= n;
		}
		
		// Add the white back in.
		r += w;
		g += w;
		b += w;
		
		// And return back the ryb typed accordingly.
		return 0xFF000000 | ((r & 0xFF) << 16 ) | ((g & 0xFF) << 8) | (b & 0xFF);
	}
}