package at.leichtgewicht.color.dim2.rgb {
	import at.leichtgewicht.color.dim2.I2DGradient;

	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RGBGBGradient extends EventDispatcher implements I2DGradient {
		
		
		[Embed("gb.pbj", mimeType="application/octet-stream")]
		private static const GBFilter:Class;
		
		public const _shader: Shader = new Shader(new GBFilter() as ByteArray);
		
		private var _red: uint;
		private var _r: uint;
		
		public function RGBGBGradient( red: uint ) {
			this.red = red;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return  _r | ( ( xPercent * 255.0 ) << 8 ) | uint( yPercent * 255.0 );
		}
		
		[Bindable(event="change")]
		public function set red( red: uint ): void {
			if( _red != red ) {
				_red = red;
				_r = 0xFF000000 | (red << 16);
				_shader.data["r"]["value"] = [ red / 255 ];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get red(): uint {
			return _red;
		}
	}
}
