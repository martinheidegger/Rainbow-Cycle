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
	public class HSBHBGradient extends EventDispatcher implements I2DGradient {
		
		[Embed("hb.pbj", mimeType="application/octet-stream")]
		private static const HBFilter:Class;
		
		public const _shader: Shader = new Shader(new HBFilter() as ByteArray);
		
		private var _saturation: Number;
		
		public function HSBHBGradient( saturation: Number ) {
			this.saturation = saturation;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return HSBtoUint( xPercent * 360.0, _saturation, yPercent );
		}
		
		public function get saturation(): Number {
			return _saturation;
		}
		
		[Bindable(event="change")]
		public function set saturation( saturation: Number ): void {
			if( _saturation != saturation ) {
				_saturation = saturation;
				_shader.data["saturation"]["value"] = [saturation];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
	}
}
