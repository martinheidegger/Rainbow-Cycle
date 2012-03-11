package at.leichtgewicht.color.linear.rgb {
	import at.leichtgewicht.color.linear.ILinearGradient;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RGBRGradient extends EventDispatcher implements ILinearGradient {
		
		private var _gb: uint;
		private var _green: uint;
		private var _blue: uint;
		
		public function RGBRGradient( green: uint, blue: uint ) {
			_green = green;
			_blue = blue;
			_gb = (_green << 8) | _blue | 0xFF000000;
		}
		
		public function getColor( percent: Number ): uint {
			return _gb | ( (255.0 * percent) << 16 );
		}
		
		[Bindable(event="change")]
		public function set blue( blue: uint ): void {
			if( _blue != blue ) {
				_blue = blue;
				_gb = (_green << 8) | _blue | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get blue(): uint {
			return _blue;
		}
		
		[Bindable(event="change")]
		public function set green( green: uint ): void {
			if( _green != green ) {
				_green = green;
				_gb = (_green << 8) | _blue | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get green(): uint {
			return _green;
		}
	}
}
