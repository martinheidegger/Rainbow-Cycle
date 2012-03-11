package at.leichtgewicht.color.linear.lab {
	import at.leichtgewicht.color.linear.ILinearGradient;
	import at.leichtgewicht.color.util.CieLABtoUint;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class LABLGradient extends EventDispatcher implements ILinearGradient {
		
		private var _a: Number;
		private var _b: Number;
		
		public function LABLGradient( a: Number, b: Number ) {
			_a = a;
			_b = b;
		}
		
		public function getColor( percent: Number ): uint {
			return CieLABtoUint(percent * 100.0, _a, _b);
		}
		
		public function get a() : Number {
			return _a;
		}
		
		[Bindable(event="change")]
		public function set a( a: Number ): void {
			if( _a != a ) {
				_a = a;
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
