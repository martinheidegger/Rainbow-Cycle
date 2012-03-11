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
	public class RYBRBGradient extends EventDispatcher implements I2DGradient {
		
		
		[Embed("rb.pbj", mimeType="application/octet-stream")]
		private static const RBFilter:Class;
		
		public const _shader: Shader = new Shader(new RBFilter() as ByteArray);
		
		private var _yellow: uint;
		private var _y: uint;
		
		public function RYBRBGradient( yellow: uint ) {
			this.sYellow = yellow;
		}
		
		public function get shader(): Shader {
			return _shader;
		}
		
		public function getColor( xPercent: Number, yPercent: Number ): uint {
			return  RYBtoUint( _y | ( ( xPercent * 255.0 ) << 16 ) | uint( yPercent * 255.0 ) );
		}
		
		[Bindable(event="change")]
		public function set sYellow( yellow: uint ): void {
			if( _yellow != yellow ) {
				_yellow = yellow;
				_y = 0xFF000000 | (yellow << 8);
				_shader.data["y"]["value"] = [ yellow / 255 ];
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get sYellow(): uint {
			return _yellow;
		}
	}
}
