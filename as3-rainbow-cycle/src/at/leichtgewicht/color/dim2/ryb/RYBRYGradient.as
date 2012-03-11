package at.leichtgewicht.color.dim2.ryb {
	import at.leichtgewicht.color.util.RYBtoUint;
	import at.leichtgewicht.color.dim2.I2DGradient;

	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class RYBRYGradient extends EventDispatcher implements I2DGradient {
		
		
		[Embed("ry.pbj", mimeType="application/octet-stream")]
		private static const RYFilter:Class;
		
		public const _shader: Shader = new Shader(new RYFilter() as ByteArray);
		
		private var _blue: uint;
		private var _b: uint;
		
		public function RYBRYGradient( blue: uint ) {
			this.sBlue = blue;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return  RYBtoUint( _b | ( ( xPercent * 255.0 ) << 16 ) | ( ( yPercent * 255.0 ) << 8 ) );
		}
		
		[Bindable(event="change")]
		public function set sBlue( blue: uint ): void {
			if( _blue != blue ) {
				_blue = blue;
				_b = 0xFF000000 | (blue << 8);
				_shader.data["b"]["value"] = [ blue / 255 ];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get sBlue(): uint {
			return _blue;
		}
	}
}
