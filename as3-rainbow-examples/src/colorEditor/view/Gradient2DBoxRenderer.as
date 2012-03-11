package colorEditor.view {
	import at.leichtgewicht.color.dim2.I2DGradient;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.events.Event;
	import flash.filters.ShaderFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class Gradient2DBoxRenderer extends Bitmap {
		
		private var _gradient: I2DGradient;
		
		public function get gradient(): I2DGradient {
			return _gradient;
		}
		
		public function set gradient( gradient: I2DGradient ): void {
			if( _gradient != gradient ) {
				if( _gradient ) {
					_gradient.removeEventListener( Event.CHANGE, update );
				}
				if( gradient ) {
					gradient.addEventListener( Event.CHANGE, update, false, 0, true );
				}
				_gradient = gradient;
				update();
			}
		}
		
		private function update( e: Event = null): void {
			var width: Number = 256;
			var height: Number = 256;
			if( bitmapData && bitmapData.width != width && bitmapData.height != height ) {
				bitmapData.dispose();
				bitmapData = null;
			}
			if( !bitmapData ){
				bitmapData = new BitmapData( width, height, true );
			}
			var rect: Rectangle = new Rectangle( 0, 0, width, height );
//			var vect: Vector.<uint> = bitmapData.getVector( rect );
//			var xPercStep: Number = 1.0 / width;
//			var yPercStep: Number = 1.0 / height;
//			var step: int = 0;
//			for( var yPerc: Number = .0; yPerc < 1.0; yPerc += yPercStep ) {
//				for( var xPerc: Number = .0; xPerc < 1.0; xPerc += xPercStep ) {
//					vect[step] = _gradient.getColor( xPerc, yPerc );
//					++step;
//				}
//			}
//			bitmapData.lock();
//			bitmapData.setVector( rect, vect );
//			bitmapData.unlock();
			var shader: Shader = _gradient.shader;
			shader.data["size"]["value"] = [width,height];
			var filter: ShaderFilter = new ShaderFilter( shader );
			bitmapData.applyFilter( bitmapData, rect, new Point( 0, 0 ), filter );
		}
	}
}