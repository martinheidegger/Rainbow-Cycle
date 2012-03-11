package colorEditor.view {
	import at.leichtgewicht.color.linear.ILinearGradient;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class Gradient1DLineRenderer extends Bitmap {
		
		private var _gradient: ILinearGradient;
		
		
		public function set gradient( gradient: ILinearGradient ): void {
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
		
		public function update( event: Event = null ): void {
			var width: Number = 256;
			var height: Number = 25;
			if( bitmapData && bitmapData.width != width && bitmapData.height != height ) {
				bitmapData.dispose();
				bitmapData = null;
			}
			if( !bitmapData ){
				bitmapData = new BitmapData( width, height, true );
			}
			vertLine.height = height;
			for( var i: int = width; i>=0; --i ) {
				vertLine.x = width-i;
				bitmapData.fillRect( vertLine, gradient.getColor( i/width ) );
			}
		}
		
		public function get gradient(): ILinearGradient {
			return _gradient;
		}
	}
}
import flash.geom.Rectangle;

const vertLine: Rectangle = new Rectangle( 0, 0, 1, 0 );