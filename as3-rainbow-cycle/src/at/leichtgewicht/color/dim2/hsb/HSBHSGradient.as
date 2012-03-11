package at.leichtgewicht.color.dim2.hsb {
	import at.leichtgewicht.color.dim2.I2DGradient;
	import at.leichtgewicht.color.util.HSBtoUint;

	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class HSBHSGradient extends EventDispatcher implements I2DGradient {
		
		[Embed("hs.pbj", mimeType="application/octet-stream")]
		private static const HSFilter:Class;
		
		public const _shader: Shader = new Shader(new HSFilter() as ByteArray);
		
		private var _brightness: Number;
		
		public function HSBHSGradient( brightness: Number ) {
			this.brightness = brightness;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return HSBtoUint( xPercent * 360.0, yPercent, _brightness );
		}
		
		public function get brightness(): Number {
			return _brightness;
		}
		
		[Bindable(event="change")]
		public function set brightness( brightness: Number ): void {
			if( _brightness != brightness ) {
				_brightness = brightness;
				_shader.data["brightness"]["value"] = [brightness];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
	}
}
