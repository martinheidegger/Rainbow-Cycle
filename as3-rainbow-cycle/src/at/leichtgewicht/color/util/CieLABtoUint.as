package at.leichtgewicht.color.util {
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public function CieLABtoUint( l: Number, a: Number, b: Number ): uint {
		
		var y: Number = (l + 16.0) / 116.0;
		var x: Number = a / 500.0 + y;
		var z: Number = y - b / 200.0;
		
		var kub: Number;
		
		kub = x * x * x;
		x = ( kub > 0.008856 ) ? kub * XC : (x - C16by116) * XCF;
		
		kub = y * y * y;
		//Y = Y * 1
		y = ( kub > 0.008856 ) ? kub : (y - C16by116) / F;
		
		kub = z * z * z; 
		z = ( kub > 0.008856 ) ? kub * ZC : (z - C16by116) * ZCF;
		
		
		var rgbR: Number = (x * +3.2406 + y * -1.5372 + z * -0.4986);
		var rgbG: Number = (x * -0.9689 + y * +1.8758 + z * +0.0415);
		var rgbB: Number = (x * +0.0557 + y * -0.2040 + z * +1.0570);
		
		rgbR = ( rgbR > 0.0031308 ) ? (1.055 * Math.pow(rgbR, C1by2p4) - 0.055) : 12.92 * rgbR;
		rgbG = ( rgbG > 0.0031308 ) ? (1.055 * Math.pow(rgbG, C1by2p4) - 0.055) : 12.92 * rgbG;
		rgbB = ( rgbB > 0.0031308 ) ? (1.055 * Math.pow(rgbB, C1by2p4) - 0.055) : 12.92 * rgbB;
		
		if( rgbR < 0 )			rgbR = 0;
		else if( rgbR > 1.0 )	rgbR = 1.0;
		
		if( rgbG < 0 )			rgbG = 0;
		else if( rgbG > 1.0 )	rgbG = 1.0;
		
		if( rgbB < 0 )			rgbB = 0;
		else if( rgbB > 1.0 )	rgbB = 1.0;
		
		return ( (uint( rgbR * 255.0 ) << 16) | (uint( rgbG * 255.0 ) << 8) | uint(rgbB * 255.0) ) | 0xFF000000;
	}
}

const C16by116: Number = 0.137931034482759; // 16/116
const C1by2p4: Number = 0.416666666666667;  // 1/2.4
const F: Number = 7.787;
const XC: Number = 0.95047; //Observer= 2°, Illuminant= D65
const XCF: Number = XC / F;
const ZC: Number = 1.08883;
const ZCF: Number = ZC / F;