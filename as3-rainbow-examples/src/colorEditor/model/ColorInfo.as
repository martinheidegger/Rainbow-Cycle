package colorEditor.model {
	import at.leichtgewicht.color.util.UinttoRYB;
	import at.leichtgewicht.color.util.RYBtoUint;
	import at.leichtgewicht.color.dim2.hsb.HSBHBGradient;
	import at.leichtgewicht.color.dim2.hsb.HSBHSGradient;
	import at.leichtgewicht.color.dim2.hsb.HSBSBGradient;
	import at.leichtgewicht.color.dim2.lab.LABABGradient;
	import at.leichtgewicht.color.dim2.lab.LABLAGradient;
	import at.leichtgewicht.color.dim2.lab.LABLBGradient;
	import at.leichtgewicht.color.dim2.rgb.RGBGBGradient;
	import at.leichtgewicht.color.dim2.rgb.RGBRBGradient;
	import at.leichtgewicht.color.dim2.rgb.RGBRGGradient;
	import at.leichtgewicht.color.dim2.ryb.RYBRBGradient;
	import at.leichtgewicht.color.dim2.ryb.RYBRYGradient;
	import at.leichtgewicht.color.dim2.ryb.RYBYBGradient;
	import at.leichtgewicht.color.linear.hsb.HSBBGradient;
	import at.leichtgewicht.color.linear.hsb.HSBHGradient;
	import at.leichtgewicht.color.linear.hsb.HSBSGradient;
	import at.leichtgewicht.color.linear.lab.LABAGradient;
	import at.leichtgewicht.color.linear.lab.LABBGradient;
	import at.leichtgewicht.color.linear.lab.LABLGradient;
	import at.leichtgewicht.color.linear.rgb.RGBBGradient;
	import at.leichtgewicht.color.linear.rgb.RGBGGradient;
	import at.leichtgewicht.color.linear.rgb.RGBRGradient;
	import at.leichtgewicht.color.linear.ryb.RYBBGradient;
	import at.leichtgewicht.color.linear.ryb.RYBRGradient;
	import at.leichtgewicht.color.linear.ryb.RYBYGradient;
	import at.leichtgewicht.color.util.CieLABtoUint;
	import at.leichtgewicht.color.util.HSBtoUint;

	import colorEditor.util.HSB;
	import colorEditor.util.LAB;
	import colorEditor.util.hsbFromRGB;
	import colorEditor.util.labFromRGB;

	import nanosome.notify.observe.Observable;

	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class ColorInfo extends Observable {
		
		public static const RED: LimitedProperty	= new LimitedProperty( "red",	0.0, 255.0 );
		public static const GREEN: LimitedProperty	= new LimitedProperty( "green",	0.0, 255.0 );
		public static const BLUE: LimitedProperty	= new LimitedProperty( "blue",	0.0, 255.0 );
		
		public static const SUB_RED: LimitedProperty	= new LimitedProperty( "sRed",		0.0, 255.0 );
		public static const SUB_YELLOW: LimitedProperty	= new LimitedProperty( "sYellow",	0.0, 255.0 );
		public static const SUB_BLUE: LimitedProperty	= new LimitedProperty( "sBlue",		0.0, 255.0 );
		
		public static const LAB_L: LimitedProperty = new LimitedProperty( "l",    0.0, 100.0 );
		public static const LAB_A: LimitedProperty = new LimitedProperty( "a", -127.0, 128.0 );
		public static const LAB_B: LimitedProperty = new LimitedProperty( "b", -127.0, 128.0 );
		
		public static const HUE: LimitedProperty		= new LimitedProperty( "hue",			0.0, 360.0 );
		public static const SATURATION: LimitedProperty	= new LimitedProperty( "saturation",	0.0, 1.0 );
		public static const BRIGHTNESS: LimitedProperty	= new LimitedProperty( "brightness",	0.0, 1.0 );
		
		public static const RED_3D: ThreeDProperty		= new ThreeDProperty( RED, GREEN, BLUE, RGBRGradient, RGBGBGradient );
		public static const GREEN_3D: ThreeDProperty	= new ThreeDProperty( GREEN, RED, BLUE, RGBGGradient, RGBRBGradient );
		public static const BLUE_3D: ThreeDProperty		= new ThreeDProperty( BLUE, RED, GREEN, RGBBGradient, RGBRGGradient );
		
		public static const SUB_RED_3D: ThreeDProperty		= new ThreeDProperty( SUB_RED, SUB_YELLOW, SUB_BLUE, RYBRGradient, RYBYBGradient );
		public static const SUB_YELLOW_3D: ThreeDProperty	= new ThreeDProperty( SUB_YELLOW, SUB_RED, SUB_BLUE, RYBYGradient, RYBRBGradient );
		public static const SUB_BLUE_3D: ThreeDProperty		= new ThreeDProperty( SUB_BLUE, SUB_RED, SUB_YELLOW, RYBBGradient, RYBRYGradient );
		
		public static const LAB_L_3D: ThreeDProperty	= new ThreeDProperty( LAB_L, LAB_A, LAB_B, LABLGradient, LABABGradient );
		public static const LAB_A_3D: ThreeDProperty	= new ThreeDProperty( LAB_A, LAB_L, LAB_B, LABAGradient, LABLBGradient );
		public static const LAB_B_3D: ThreeDProperty	= new ThreeDProperty( LAB_B, LAB_L, LAB_A, LABBGradient, LABLAGradient );
		
		public static const HUE_3D: ThreeDProperty			= new ThreeDProperty( HUE, SATURATION, BRIGHTNESS, HSBHGradient, HSBSBGradient );
		public static const SATURATION_3D: ThreeDProperty	= new ThreeDProperty( SATURATION, HUE, BRIGHTNESS, HSBSGradient, HSBHBGradient );
		public static const BRIGHTNESS_3D: ThreeDProperty	= new ThreeDProperty( BRIGHTNESS, HUE, SATURATION, HSBBGradient, HSBHSGradient );
		
		private var _red: uint;
		private var _green: uint;
		private var _blue: uint;
		
		private var _hue: Number;
		private var _saturation: Number;
		private var _brightness: Number;
		
		private var _l: Number;
		private var _a: Number;
		private var _b: Number;
		private var _rgb: uint;
		private var _hex : String;
		private var _sRed : *;
		private var _sYellow : uint;
		private var _sBlue : uint;
		
		public function ColorInfo( color: uint ) {
			
			_red =   (color & 0xFF0000) >> 16;
			_green = (color &   0xFF00) >> 8;
			_blue =   color &     0xFF;
			
			_rgb = color;
			_hex = createHex();
			
			updateRYBfromRGB();
			updateHSBfromRGB();
			updateLABfromRGB();
		}
		
		private function createHex(): String {
			var rH: String = _red.toString( 16 );
			if( rH.length == 1 ) {
				rH = "0"+rH;
			}
			var gH: String = _green.toString( 16 );
			if( gH.length == 1 ) {
				gH = "0"+gH;
			}
			var bH: String = _blue.toString( 16 );
			if( bH.length == 1 ) {
				bH = "0"+bH;
			}
			return "#" + rH + gH + bH;
		}
		
		[Observable]
		public function set red( red: uint ): void {
			if( _red != red ) {
				notifyPropertyChange( RED.name, _red, _red = red );
				updateNonRGB();
			}
		}
		
		public function get red(): uint {
			return _red;
		}
		
		[Observable]
		public function set green( green: uint ): void {
			if( _green != green ) {
				notifyPropertyChange( GREEN.name, _green, _green = green );
				updateNonRGB();
			}
		}
		
		public function get green(): uint {
			return _green;
		}
		
		[Observable]
		public function set blue( blue: uint ): void {
			if( _blue != blue ) {
				notifyPropertyChange( BLUE.name, _blue, _blue = blue );
				updateNonRGB();
			}
		}
		
		public function get blue(): uint {
			return _blue;
		}
		
		[Observable]
		public function set sRed( sRed: uint ): void {
			if( _sRed != sRed ) {
				notifyPropertyChange( SUB_RED.name, _sRed, _sRed = sRed );
				updateNonRYB();
			}
		}
		
		public function get sRed(): uint {
			return _sRed;
		}
		
		[Observable]
		public function set sYellow( sYellow: uint ): void {
			if( _sYellow != sYellow ) {
				notifyPropertyChange( SUB_YELLOW.name, _sYellow, _sYellow = sYellow );
				updateNonRYB();
			}
		}
		
		public function get sYellow(): uint {
			return _sYellow;
		}
		
		[Observable]
		public function set sBlue( sBlue: uint ): void {
			if( _sBlue != sBlue ) {
				notifyPropertyChange( SUB_BLUE.name, _sBlue, _sBlue = sBlue );
				updateNonRYB();
			}
		}
		
		public function get sBlue(): uint {
			return _sBlue;
		}
		
		[Observable]
		public function set hue( hue: Number ): void {
			if( _hue != hue ) {
				notifyPropertyChange( HUE.name, _hue, _hue = hue );
				updateNonHSB();
			}
		}
		
		public function get hue(): Number {
			return _hue;
		}
		
		[Observable]
		public function set saturation( saturation: Number ): void {
			if( _saturation != saturation ) {
				notifyPropertyChange( SATURATION.name, _saturation, _saturation = saturation );
				updateNonHSB();
			}
		}
		
		public function get saturation(): Number {
			return _saturation;
		}
		
		[Observable]
		public function set brightness( brightness: Number ): void {
			if( _brightness != brightness ) {
				notifyPropertyChange( BRIGHTNESS.name, _brightness, _brightness = brightness );
				updateNonHSB();
			}
		}
		
		public function get brightness(): Number {
			return _brightness;
		}
		
		[Observable]
		public function set l( labL: Number ): void {
			if( _l != labL ) {
				notifyPropertyChange( LAB_L.name, _l, _l = labL );
				updateNonLab();
			}
		}
		
		public function get l(): Number {
			return _l;
		}
		
		[Observable]
		public function set a( labA: Number ): void {
			if( _a != labA ) {
				notifyPropertyChange( LAB_A.name, _a, _a = labA );
				updateNonLab();
			}
		}
		
		public function get a(): Number {
			return _a;
		}
		
		[Observable]
		public function set b( labB: Number ): void {
			if( _b != labB ) {
				notifyPropertyChange( LAB_B.name, _b, _b = labB );
				updateNonLab();
			}
		}
		
		public function get b(): Number {
			return _b;
		}
		
		private function updateNonRGB() : void {
			updateLABfromRGB();
			updateHSBfromRGB();
			updateRYBfromRGB();
			updateColor();
		}
		
		private function updateNonRYB() : void {
			updateRGBfromRYB();
			updateLABfromRGB();
			updateHSBfromRGB();
			updateColor();
		}
		
		private function updateNonLab() : void {
			updateRGBfromLAB();
			updateHSBfromRGB();
			updateRYBfromRGB();
			updateColor();
		}
		
		private function updateNonHSB(): void {
			updateRGBfromHSB();
			updateLABfromRGB();
			updateRYBfromRGB();
			updateColor();
		}
		
		private function updateRGBfromRYB() : void {
			updateRGB( RYBtoUint( (_sRed << 16) | ( _sYellow << 8 ) | _sBlue ) );
		}
		
		private function updateRYBfromRGB() : void {
			updateRYB( UinttoRYB( _rgb ) );
		}
		
		private function updateHSBfromRGB(): void {
			updateHSB( hsbFromRGB( _red, _green, _blue ) );
		}
		
		private function updateRGBfromHSB(): void {
			updateRGB( HSBtoUint( _hue, _saturation, _brightness ) );
		}
		
		private function updateRGBfromLAB(): void {
			updateRGB( CieLABtoUint( _l, _a, _b ) );
		}
		
		private function updateLABfromRGB(): void {
			updateLAB( labFromRGB( _red/255.0, _green/255.0, _blue/255.0 ) );
		}
		
		private function updateColor(): void {
			var rgb: uint = 0xFF000000 | (_red << 16) | (_green << 8) | _blue;
			if( rgb != _rgb ) {
				notifyPropertyChange( RGB, _rgb, _rgb = rgb );
				notifyPropertyChange( HEX, _hex, _hex = createHex() );
			}
		}
		
		private function updateRGB( color: uint ): void {
			var red: uint =   uint( ( color & 0xFF0000 ) >> 16 );
			var green: uint = uint( ( color & 0xFF00 ) >> 8 );
			var blue: uint =  uint(   color & 0xFF );
			
			if( red != _red )		notifyPropertyChange( RED.name, _red, _red = red );
			if( green != _green )	notifyPropertyChange( GREEN.name, _green, _green = green );
			if( blue != _blue )		notifyPropertyChange( BLUE.name, _blue, _blue = blue );
		}
		
		private function updateRYB( ryb: uint ): void {
			var r: uint = ( ryb & 0xFF0000 ) >> 16;
			var y: uint = ( ryb & 0xFF00 ) >> 8;
			var b: uint = ( ryb & 0xFF );
			
			if( r != _sRed )	notifyPropertyChange( SUB_RED.name, _sRed, _sRed = r );
			if( y != _sYellow )	notifyPropertyChange( SUB_YELLOW.name, _sYellow, _sYellow = y );
			if( b != _sBlue )	notifyPropertyChange( SUB_BLUE.name, _sBlue, _sBlue = b );
		}
		
		private function updateHSB( hsb: HSB ): void {
			if( isNaN( hsb.h ) ) {
				hsb.h = _hue;
				hsb.s = 0;
				hsb.b = 1.0;
			}
			if( hsb.h != _hue ) notifyPropertyChange( HUE.name, _hue, _hue = hsb.h );
			if( hsb.s != _saturation ) notifyPropertyChange( SATURATION.name, _saturation, _saturation = hsb.s );
			if( hsb.b != _brightness ) notifyPropertyChange( BRIGHTNESS.name, _brightness, _brightness = hsb.b );
		}
		
		private function updateLAB( lab: LAB ): void {
			if( lab.l != _l ) notifyPropertyChange( LAB_L.name, _l, _l = lab.l );
			if( lab.a != _a ) notifyPropertyChange( LAB_A.name, _a, _a = lab.a );
			if( lab.b != _b ) notifyPropertyChange( LAB_B.name, _b, _b = lab.b );
		}
		
		[Observable]
		public function get rgb(): uint {
			return _rgb;
		}
		
		
		public function set rgb( rgb: uint ): void  {
			rgb = rgb | 0xFF000000;
			if( rgb != _rgb ) {
				
				var r: Number = ( rgb & 0xFF0000 ) >> 16;
				var g: Number = ( rgb & 0xFF00 ) >> 8;
				var b: Number = rgb & 0xFF;
				if( r != _red ) notifyPropertyChange( RED.name, _red, _red = r );
				if( g != _green ) notifyPropertyChange( GREEN.name, _green, _green = g );
				if( b != _blue ) notifyPropertyChange( BLUE.name, _blue, _blue = b );
				notifyPropertyChange( RGB, _rgb, _rgb = rgb );
				notifyPropertyChange( HEX, _hex, _hex = createHex() );
				updateNonRGB();
			}
		}
		
		public function get hex(): String {
			return _hex;
		}
		
		[Observable]
		public function set hex( hex: String ): void {
			if( hex != _hex ) {
				var pHex: String = hex;
				if( pHex.charAt(0) == "#" ) {
					pHex = pHex.substr(1);
				}
				if( pHex.length < 7 ) {
					var rgb: uint = parseInt( pHex, 16 );
					if( isNaN( rgb ) ){
						throw new Error( "not parsable" );
					}
					rgb = 0xFF000000 | rgb;
					var r: Number = ( rgb & 0xFF0000 ) >> 16;
					var g: Number = ( rgb & 0xFF00 ) >> 8;
					var b: Number = rgb & 0xFF;
					notifyPropertyChange( HEX, _hex, _hex = hex );
					if( r != _red )   notifyPropertyChange( RED.name, _red, _red = r );
					if( g != _green ) notifyPropertyChange( GREEN.name, _green, _green = g );
					if( b != _blue )  notifyPropertyChange( BLUE.name, _blue, _blue = b );
					if( rgb != _rgb ) notifyPropertyChange( RGB, _rgb, _rgb = rgb );
					updateNonRGB();
				} else {
					throw new Error( "unexpected input size" );
				}
			}
		}
	}
}
import nanosome.util.access.qname;

const HEX: QName = qname( "hex" );
const RGB: QName = qname( "rgb" );