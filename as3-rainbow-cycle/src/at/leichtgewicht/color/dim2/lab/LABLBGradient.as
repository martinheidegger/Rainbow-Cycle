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
	public class LABLBGradient extends EventDispatcher implements I2DGradient {
		
		[Embed("lb.pbj", mimeType="application/octet-stream")]
		private static const LBFilter:Class;
		
		public const _shader: Shader = new Shader(new LBFilter() as ByteArray);
		
		private var _a: Number;
		
		public function LABLBGradient( a: Number ) {
			this.a = a;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return CieLABtoUint(xPercent * 100.0, _a, yPercent * 255.0 - 127.0);
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function get a() : Number {
			return _a;
		}
		
		[Bindable(event="change")]
		public function set a( a: Number ): void {
			if( _a != a ) {
				_a = a;
				_shader.data["a"]["value"] = [a];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
	}
}
