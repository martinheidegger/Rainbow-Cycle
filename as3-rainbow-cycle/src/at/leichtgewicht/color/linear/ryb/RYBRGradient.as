package at.leichtgewicht.color.linear.ryb {
	import at.leichtgewicht.color.util.RYBtoUint;
	import at.leichtgewicht.color.linear.ILinearGradient;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RYBRGradient extends EventDispatcher implements ILinearGradient {
		
		private var _yb: uint;
		private var _yellow: uint;
		private var _blue: uint;
		
		public function RYBRGradient( yellow: uint, blue: uint ) {
			_yellow = yellow;
			_blue = blue;
			_yb = (_yellow << 8) | _blue | 0xFF000000;
		}
		
		public function getColor( percent: Number ): uint {
			return RYBtoUint( _yb | ( (255.0 * percent) << 16 ) );
		}
		
		[Bindable(event="change")]
		public function set sBlue( blue: uint ): void {
			if( _blue != blue ) {
				_blue = blue;
				_yb = (_yellow << 8) | _blue | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get sBlue(): uint {
			return _blue;
		}
		
		[Bindable(event="change")]
		public function set sYellow( yellow: uint ): void {
			if( _yellow != yellow ) {
				_yellow = yellow;
				_yb = (_yellow << 8) | _blue | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get sYellow(): uint {
			return _yellow;
		}
	}
}
