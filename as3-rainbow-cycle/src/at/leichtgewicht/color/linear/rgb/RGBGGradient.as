package at.leichtgewicht.color.linear.rgb {
	
	import at.leichtgewicht.color.linear.ILinearGradient;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RGBGGradient extends EventDispatcher implements ILinearGradient {
		
		private var _rb: uint;
		private var _red: uint;
		private var _blue: uint;
		
		public function RGBGGradient( red: uint, blue: uint ) {
			_red = red;
			_blue = blue;
			_rb = (red << 16) | blue | 0xFF000000;
		}
		
		public function getColor( percent: Number ): uint {
			return _rb | ( (255.0 * percent) << 8 );
		}
		
		[Bindable(event="change")]
		public function set blue( blue: uint ): void {
			if( _blue != blue ) {
				_blue = blue;
				_rb = (_red << 16) | _blue | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get blue(): uint {
			return _blue;
		}
		
		[Bindable(event="change")]
		public function set red( red: uint ): void {
			if( _red != red ) {
				_red = red;
				_rb = (_red << 16) | _blue | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get red(): uint {
			return _red;
		}
	}
}
