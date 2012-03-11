package at.leichtgewicht.color.linear {
	import flash.events.EventDispatcher;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class TwoColorGradient extends EventDispatcher implements ILinearGradient {
		
		private var _colorAA: uint;
		private var _colorAR: uint;
		private var _colorAG: uint;
		private var _colorAB: uint;
		
		private var _colorRDiff: Number;
		private var _colorGDiff: Number;
		private var _colorBDiff: Number;
		private var _colorADiff: Number;
		
		public function TwoColorGradient( colorA: uint, colorB: uint ) {
			_colorAA = ( colorA & 0xFF000000 ) >> 24;
			_colorAR = ( colorA &   0xFF0000 ) >> 16;
			_colorAG = ( colorA &     0xFF00 ) >> 8;
			_colorAB = ( colorA &       0xFF );
			_colorADiff = ( ( colorB & 0xFF000000 ) - ( colorA & 0xFF000000 ) ) >> 24;
			_colorRDiff = ( ( colorB &   0xFF0000 ) - ( colorA &   0xFF0000 ) ) >> 16;
			_colorGDiff = ( ( colorB &     0xFF00 ) >> 8 ) - _colorAG;
			_colorBDiff = ( ( colorB &       0xFF ) ) - _colorAB;
		}
		
		public function getColor( percent: Number ): uint {
			return ( ( _colorAA + _colorADiff * percent ) << 24 ) +
				( ( _colorAR + _colorRDiff * percent ) << 16 ) +
				( ( _colorAG + _colorGDiff * percent ) << 8 ) +
				( _colorAB + _colorBDiff * percent );
		}
	}
}
