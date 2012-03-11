package at.leichtgewicht.color.dim2.lab {
	import at.leichtgewicht.color.dim2.I2DGradient;
	import at.leichtgewicht.color.util.CieLABtoUint;

	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class LABLAGradient extends EventDispatcher implements I2DGradient {
		
		[Embed("la.pbj", mimeType="application/octet-stream")]
		private static const LAFilter:Class;
		
		public const _shader: Shader = new Shader(new LAFilter() as ByteArray);
		
		private var _b: Number;
		
		public function LABLAGradient( b: Number ) {
			this.b = b;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return CieLABtoUint( xPercent * 100.0, yPercent * 255.0 - 127.0, _b );
		}
		
		public function get b(): Number {
			return _b;
		}
		
		[Bindable(event="change")]
		public function set b( b: Number ): void {
			if( _b != b ) {
				_b = b;
				_shader.data["b"]["value"] = [b];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
	}
}
