package at.leichtgewicht.color.linear.lab {
	import at.leichtgewicht.color.linear.ILinearGradient;
	import at.leichtgewicht.color.util.CieLABtoUint;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class LABBGradient extends EventDispatcher implements ILinearGradient {
		
		private var _l: Number;
		private var _a: Number;
		
		public function LABBGradient( l: Number, a: Number ) {
			_l = l;
			_a = a;
		}
		
		public function getColor( percent: Number ): uint {
			return CieLABtoUint(_l, _a, percent * 255.0 - 127.0);
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
	}
}
