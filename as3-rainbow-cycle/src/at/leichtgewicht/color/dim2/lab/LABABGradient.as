package at.leichtgewicht.color.dim2.lab {
	import at.leichtgewicht.color.util.CieLABtoUint;
	import at.leichtgewicht.color.dim2.I2DGradient;

	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class LABABGradient extends EventDispatcher implements I2DGradient {
		
		[Embed("ab.pbj", mimeType="application/octet-stream")]
		private static const ABFilter:Class;
		
		public const _shader: Shader = new Shader(new ABFilter() as ByteArray);
		
		private var _l: Number;
		
		public function LABABGradient( l: Number ) {
			this.l = l;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return CieLABtoUint( l, xPercent * 256.0 - 127.0, yPercent * 256.0 - 127.0 );
		}
		
		public function get l(): Number {
			return _l;
		}
		
		[Bindable(event="change")]
		public function set l( l: Number ): void {
			if( _l != l ) {
				_l = l;
				_shader.data["l"]["value"] = [l];
				dispatchEvent( new Event( Event.CHANGE ) );
			} 
		}
	}
}