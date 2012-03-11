package at.leichtgewicht.color.linear.ryb {
	import at.leichtgewicht.color.util.RYBtoUint;
	import at.leichtgewicht.color.linear.ILinearGradient;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RYBBGradient extends EventDispatcher implements ILinearGradient {
		
		private var _ry: uint;
		private var _yellow: uint;
		private var _red: uint;
		
		public function RYBBGradient( red: uint, yellow: uint ) {
			_yellow = yellow;
			_red = red;
			_ry = (_red << 16 ) | (_yellow << 8) | 0xFF000000;
		}
		
		public function getColor( percent: Number ): uint {
			return RYBtoUint( _ry | ( (255.0 * percent ) & 0xFF ) );
		}
		
		[Bindable(event="change")]
		public function set sRed( red: uint ): void {
			if( _red != red ) {
				_red = red;
				_ry = (_red << 16 ) | (_yellow << 8) | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get sRed(): uint {
			return _red;
		}
		
		[Bindable(event="change")]
		public function set sYellow( yellow: uint ): void {
			if( _yellow != yellow ) {
				_yellow = yellow;
				_ry = (_red << 16 ) | (_yellow << 8) | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get sYellow(): uint {
			return _yellow;
		}
	}
}
