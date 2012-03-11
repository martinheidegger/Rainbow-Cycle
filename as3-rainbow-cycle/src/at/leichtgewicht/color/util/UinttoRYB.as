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
	 */
	public function UinttoRYB( rgb: uint ): uint {
		var r: Number = ( rgb & 0xFF0000 ) >> 16;
		var g: Number = ( rgb & 0xFF00 ) >> 8;
		var b: Number = ( rgb & 0xFF );
		
		// Remove the whiteness from the color.
		var w: Number = Math.min( r, g, b );
		r -= w;
		g -= w;
		b -= w;
		
		var mg: Number = Math.max( r, g, b );
		
		// Get the yellow out of the red+green.
		var y: Number = Math.min( r, g );
		r -= y;
		g -= y;
	
		// If this unfortunate conversion combines blue and green, then cut each in half to preserve the value's maximum range.
		b /= 2.0;
		g /= 2.0;
		
		// Redistribute the remaining green.
		y += g;
		b += g;
		
		// Normalize to values.
		var my: Number = Math.max( r, y, b );
		if( my > 0 ) {
			var n: Number = mg / my;
			r *= n;
			y *= n;
			b *= n;
		}	
		
		// Add the white back in.
		r += w;
		y += w;
		b += w;
		
		// And return back the ryb typed accordingly.
		return 0xFF000000 | ((r & 0xFF) << 16) | ( (g & 0xFF) << 8) | (b&0xFF);
	}
}
