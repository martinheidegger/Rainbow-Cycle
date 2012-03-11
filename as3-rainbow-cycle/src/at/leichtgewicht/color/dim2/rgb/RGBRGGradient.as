package at.leichtgewicht.color.dim2.rgb {
	import at.leichtgewicht.color.dim2.I2DGradient;

	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RGBRGGradient extends EventDispatcher implements I2DGradient {
		
		[Embed("rg.pbj", mimeType="application/octet-stream")]
		private static const RGFilter:Class;
		
		public const _shader: Shader = new Shader(new RGFilter() as ByteArray);
		
		private var _blue: Number;
		private var _b: uint;
		
		public function RGBRGGradient( blue: Number ) {
			this.blue = blue;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return  _b | ( ( xPercent * 255.0 ) << 16 ) | uint( yPercent * 255.0 << 8 );
		}
		
		public function get blue(): Number {
			return _blue;
		}
		
		[Bindable(event="change")]
		public function set blue( blue: Number ): void {
			if( _blue != blue ) {
				_blue = blue;
				_b = 0xFF000000 | blue;
				_shader.data["b"]["value"] = [ blue / 255 ];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
	}
}
