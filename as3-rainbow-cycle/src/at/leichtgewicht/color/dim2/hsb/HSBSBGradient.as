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
	public class HSBSBGradient extends EventDispatcher implements I2DGradient {
		
		[Embed("sb.pbj", mimeType="application/octet-stream")]
		private static const SBFilter:Class;
		
		public const _shader: Shader = new Shader(new SBFilter() as ByteArray);
		
		private var _hue: Number;
		
		public function HSBSBGradient( hue: Number ) {
			this.hue = hue;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return HSBtoUint( _hue, xPercent, yPercent);
		}
		
		public function get hue(): Number {
			return _hue;
		}
		
		[Bindable(event="change")]
		public function set hue( hue: Number ): void {
			if( _hue != hue ) {
				_hue = hue;
				_shader.data["hue"]["value"] = [hue];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
	}
}
