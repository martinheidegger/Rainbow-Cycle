package colorEditor.view {
	import flash.display.Shape;
	import at.leichtgewicht.color.linear.ILinearGradient;

	import colorEditor.util.drag;

	import nanosome.notify.observe.ObservableSprite;

	import flash.events.MouseEvent;
	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class Gradient1DLine extends ObservableSprite {
		
		private var _line: Gradient1DLineRenderer;
		private var _overlay: InteractiveOverlay;
		private var _xPos : Number;
		private var _ruler : Shape;
		
		public function Gradient1DLine() {
			super();
			addChild( _line = new Gradient1DLineRenderer() );
			addChild( _overlay = new InteractiveOverlay( _line, 256, 25 ) );
			addChild( _ruler = new Shape() );
			_overlay.addEventListener( MouseEvent.MOUSE_DOWN, select2D, false, 0, true );
		}
		
		[Observable]
		public function set gradient( gradient: ILinearGradient ): void {
			if( _line.gradient != gradient ) {
				notifyPropertyChange( GRADIENT, _line.gradient, _line.gradient = gradient );
			}
		}
		
		public function get gradient(): ILinearGradient {
			return _line.gradient;
		}
		
		private function select2D(event : MouseEvent) : void {
			// 256 is hardcoded because / width made problems while rotating
			var x: Number = 1.0-(mouseX / 256);
			if( x < 0.0 )		x = 0.0;
			else if( x > 1.0 )	x = 1.0;
			
			if( _xPos != x ) {
				notifyPropertyChange( X_POS, _xPos, _xPos = x );
				updateLine();
			}
			
			drag( select2D, stage );
		}
		
		public function get xPos(): Number {
			return _xPos;
		}
		
		[Observable]
		public function set xPos( xPos: Number) : void {
			if( _xPos != xPos ) {
				notifyPropertyChange( X_POS, _xPos, _xPos = xPos );
				updateLine();
			}
		}
		
		private function updateLine() : void {
			_ruler.graphics.clear();
			_ruler.graphics.lineStyle( 1 );
			var xRel: Number = 255.0-(_xPos*255.0);
			_ruler.graphics.moveTo( xRel, -3 );
			_ruler.graphics.lineTo( xRel, 28 );
		}
	}
}
import nanosome.util.access.qname;

import flash.geom.Rectangle;

const vertLine: Rectangle = new Rectangle( 0, 0, 1, 0 );
const GRADIENT: QName = qname( "gradient" );
const X_POS: QName = qname( "xPos" );