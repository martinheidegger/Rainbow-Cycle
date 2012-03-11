//  
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License. 
//  
package at.leichtgewicht.color.util {
	
	/**
	 * Transforms a HSB color to RGB uint value.
	 * 
	 * @param h Hue of the color from 0 to 360
	 * @param s Saturation value to be used. From 0=no saturation(grey) to 1=full saturation.
	 * @param b Brightness value to be used. From 0=black to 1=max brightness.
	 * @return RGB color value
	 */
	public function HSBtoUint( h: Number, s: Number, b: Number ): uint
	{
		if( b <= 0.0 )
		{
			return 0xFF000000;
		}
		b = ( b >= 1.0 ) ? 1.0 : b;
		
		if( s <= 0.0 )
		{
			// Safe processing time with grey, are all colors all same anyway
			return RGBtoUint( b * 255.0, b * 255.0, b * 255.0 );
		}
		else
		{
			if( h < 0.0 )
			{
				h = 360.0 - ( -h ) % 360;
			}
			h = int( h % 360 );
			s = ( s >= 1.0 ) ? 1.0 : s;
			
			// the color wheel consists of 6 sectors. Figure out which sector
			// you're in.
			var sectorPos: Number = h / 60.0;
			var sectorNumber: int = int( sectorPos );
			// get the fractional part of the sector
			var fractionalSector: Number = sectorPos - sectorNumber;

			// calculate values for the three axes of the color.
			var p: Number = b * (1.0 - s);
			var q: Number = b * (1.0 - (s * fractionalSector));
			var t: Number = b * (1.0 - (s * (1 - fractionalSector)));
			
			var r: Number;
			var g: Number;
			var b2: Number;
			
			
			// assign the fractional colors to r, g, and b based on the sector
			// the angle is in.
			if( sectorNumber < 3 ) {
				if( sectorNumber < 1 ){
					r = b; g = t; b2 = p;
				} else if( sectorNumber < 2 ) {
					r = q; g = b; b2 = p;
				} else {
					r = p; g = b; b2 = t;
				}
			} else {
				if( sectorNumber < 4 ){
					r = p; g = q; b2 = b;
				} else if( sectorNumber < 5 ) {
					r = t; g = p; b2 = b;
				} else {
					r = b; g = p; b2 = q;
				}
			}
			
			return 0xFF000000 | ( ( r * 255.0 ) << 16 ) | ( ( g * 255.0 ) << 8 ) | ( b2 * 255.0 );
		}
	}
}