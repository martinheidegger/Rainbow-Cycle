package at.leichtgewicht.color.dim2.rgb {
	import at.leichtgewicht.color.dim2.I2DGradient;

	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RGBRBGradient extends EventDispatcher implements I2DGradient {
		
		
		[Embed("rb.pbj", mimeType="application/octet-stream")]
		private static const RBFilter:Class;
		
		public const _shader: Shader = new Shader(new RBFilter() as ByteArray);
		
		private var _green: uint;
		private var _g: uint;
		
		public function RGBRBGradient( green: uint ) {
			this.green = green;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return  _g | ( ( xPercent * 255.0 ) << 16 ) | uint( yPercent * 255.0 );
		}
		
		public function get green(): uint {
			return _green;
		}
		
		[Bindable(event="change")]
		public function set green( green: uint ): void {
			if( _green != green ) {
				_green = green;
				_g = 0xFF000000 | (green << 8);
				_shader.data["g"]["value"] = [ green / 255 ];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
	}
}
