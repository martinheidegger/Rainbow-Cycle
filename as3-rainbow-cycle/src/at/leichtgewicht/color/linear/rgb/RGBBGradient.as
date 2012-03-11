package at.leichtgewicht.color.linear.rgb {
	import at.leichtgewicht.color.linear.ILinearGradient;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RGBBGradient extends EventDispatcher implements ILinearGradient {
		
		private var _rg: uint;
		private var _red: uint;
		private var _green: uint;
		
		public function RGBBGradient( red: uint, green: uint ) {
			_red = red;
			_green = green;
			_rg = (red << 16) | (green <<8 ) | 0xFF000000;
		}
		
		public function getColor( percent: Number ): uint {
			return _rg | (255.0 * percent );
		}
		
		[Bindable(event="change")]
		public function set green( green: uint ): void {
			if( _green != green ) {
				_green = green;
				_rg = (_red << 16) | (_green <<8 ) | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get green(): uint {
			return _green;
		}
		
		[Bindable(event="change")]
		public function set red( red: uint ): void {
			if( _red != red ) {
				_red = red;
				_rg = (_red << 16) | (_green <<8 ) | 0xFF000000;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get red(): uint {
			return _red;
		}
	}
}
