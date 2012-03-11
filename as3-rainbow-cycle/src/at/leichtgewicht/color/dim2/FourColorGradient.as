package at.leichtgewicht.color.dim2 {
	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class FourColorGradient extends EventDispatcher implements I2DGradient {
		
		[Embed("fourcolor.pbj", mimeType="application/octet-stream")]
		private static const FourColorFilter:Class;
		
		public const _shader: Shader = new Shader(new FourColorFilter() as ByteArray);
		
		private var _colorA: uint;
		private var _colorAA: uint;
		private var _colorAR: uint;
		private var _colorAG: uint;
		private var _colorAB: uint;
		private var _colorAADiff: uint;
		private var _colorARDiff: uint;
		private var _colorAGDiff: uint;
		private var _colorABDiff: uint;
		
		private var _colorB: uint;
		private var _colorBA: uint;
		private var _colorBR: uint;
		private var _colorBG: uint;
		private var _colorBB: uint;
		
		private var _colorC: uint;
		private var _colorCB: uint;
		private var _colorCG: uint;
		private var _colorCR: uint;
		private var _colorCA: uint;
		private var _colorCADiff: uint;
		private var _colorCRDiff: uint;
		private var _colorCGDiff: uint;
		private var _colorCBDiff: uint;
		
		private var _colorD: uint;
		private var _colorDA: uint;
		private var _colorDR: uint;
		private var _colorDB: uint;
		private var _colorDG: uint;
		
		public function FourColorGradient( colorA: uint, colorB: uint, colorC: uint, colorD: uint ) {
			this.colorA = colorA;
			this.colorB = colorB;
			this.colorC = colorC;
			this.colorD = colorD;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function set colorA( color: uint ): void {
			if( color != _colorA ) {
				_colorA = color;
				_colorAA = ( color & 0xFF000000 ) >> 24;
				_colorAR = ( color &   0xFF0000 ) >> 16;
				_colorAG = ( color &     0xFF00 ) >> 8;
				_colorAB = ( color &       0xFF );
				_shader.data["a"]["value"] = [ _colorAR / 256.0, _colorAG / 256.0, _colorAB / 256.0, _colorAA / 256.0 ];
				updateAB();
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get colorA(): uint {
			return _colorA;
		}
		
		public function set colorB( color: uint ): void {
			if( color != _colorB ) {
				_colorB = color;
				_colorBA = ( color & 0xFF000000 ) >> 24;
				_colorBR = ( color &   0xFF0000 ) >> 16;
				_colorBG = ( color &     0xFF00 ) >> 8;
				_colorBB = ( color &       0xFF );
				_shader.data["b"]["value"] = [ _colorBR / 256.0, _colorBG / 256.0, _colorBB / 256.0, _colorBA / 256.0 ];
				updateAB();
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get colorB(): uint {
			return _colorB;
		}
		
		public function set colorC( color: uint ): void {
			if( color != _colorC ) {
				_colorC = color;
				_colorCA = ( color & 0xFF000000 ) >> 24;
				_colorCR = ( color &   0xFF0000 ) >> 16;
				_colorCG = ( color &     0xFF00 ) >> 8;
				_colorCB = ( color &       0xFF );
				_shader.data["c"]["value"] = [ _colorCR / 256.0, _colorCG / 256.0, _colorCB / 256.0, _colorCA / 256.0 ];
				updateCD();
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get colorC(): uint {
			return _colorC;
		}
		
		public function set colorD( color: uint ): void {
			if( color != _colorD ) {
				_colorD = color;
				_colorDA = ( color & 0xFF000000 ) >> 24;
				_colorDR = ( color &   0xFF0000 ) >> 16;
				_colorDG = ( color &     0xFF00 ) >> 8;
				_colorDB = ( color &       0xFF );
				_shader.data["d"]["value"] = [ _colorDR / 256.0, _colorDG / 256.0, _colorDB / 256.0, _colorDA / 256.0 ];
				updateCD();
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		private function updateAB(): void {
			_colorAADiff = _colorAA - _colorBA;
			_colorARDiff = _colorAR - _colorBR;
			_colorAGDiff = _colorAG - _colorBG;
			_colorABDiff = _colorAB - _colorBB;
		}
		
		private function updateCD(): void {
			_colorCADiff = _colorDA - _colorCA;
			_colorCRDiff = _colorDR - _colorCR;
			_colorCGDiff = _colorDG - _colorCG;
			_colorCBDiff = _colorDB - _colorCB;
		}
		
		public function get colorD(): uint {
			return _colorD;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			var yInv: Number = 1.0 - yPercent;
			var a: Number = ( _colorAA + _colorAADiff * xPercent ) * yInv + ( _colorCA + _colorCADiff * xPercent ) * yPercent;
			var r: Number = ( _colorAR + _colorARDiff * xPercent ) * yInv + ( _colorCR + _colorCRDiff * xPercent ) * yPercent;
			var g: Number = ( _colorAG + _colorAGDiff * xPercent ) * yInv + ( _colorCG + _colorCGDiff * xPercent ) * yPercent;
			var b: Number = ( _colorAB + _colorABDiff * xPercent ) * yInv + ( _colorCB + _colorCBDiff * xPercent ) * yPercent;
			return  ( a << 24 ) | ( r << 16 ) | ( g << 8 ) | b;
		}
	}
}
