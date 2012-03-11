package at.leichtgewicht.color.linear.lab {
	import at.leichtgewicht.color.linear.ILinearGradient;
	import at.leichtgewicht.color.util.CieLABtoUint;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class LABAGradient extends EventDispatcher implements ILinearGradient {
		
		private var _l: Number;
		private var _b: Number;
		
		public function LABAGradient( l: Number, b: Number ) {
			_l = l;
			_b = b;
		}
		
		public function getColor( percent: Number ): uint {
			return CieLABtoUint(_l, percent * 255.0 - 127.0, _b);
		}
		
		public function get l() : Number {
			return _l;
		}
		
		[Bindable(event="change")]
		public function set l( l: Number ): void {
			if( _l != l ) {
				_l = l;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get b() : Number {
			return _b;
		}
		
		[Bindable(event="change")]
		public function set b( b: Number ): void {
			if( _b != b ) {
				_b = b;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
	}
}
