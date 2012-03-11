package colorEditor.view {
	import flash.filters.GlowFilter;
	import flash.display.Shape;
	import at.leichtgewicht.color.dim2.I2DGradient;
	import colorEditor.util.drag;
	import nanosome.notify.observe.ObservableSprite;
	import flash.events.MouseEvent;
	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class Gradient2DBox extends ObservableSprite {
		
		private var _box: Gradient2DBoxRenderer;
		private var _overlay: InteractiveOverlay;
		private var _xPos: Number;
		private var _yPos : Number;
		private var _shape : Shape;
		
		public function Gradient2DBox() {
			super();
			addChild( _box = new Gradient2DBoxRenderer() );
			addChild( _overlay = new InteractiveOverlay( _box, 256, 256 ) );
			addChild( _shape = new Shape() );
			_shape.graphics.beginFill( 0x000000 );
			_shape.graphics.drawCircle( 0, 0, 5 );
			_shape.graphics.drawCircle( 0, 0, 4 );
			_shape.filters = [ new GlowFilter( 0xFFFFFF, 1.0, 3.0, 3.0, 4 ) ];
			_overlay.addEventListener( MouseEvent.MOUSE_DOWN, select2D, false, 0, true );
		}
		
		[Observable]
		public function set gradient( gradient: I2DGradient ): void {
			if( _box.gradient != gradient ) {
				notifyPropertyChange( GRADIENT, _box.gradient, _box.gradient = gradient );
			}
		}
		
		public function get gradient(): I2DGradient {
			return _box.gradient;
		}
		
		private function select2D(event : MouseEvent) : void {
			var x: Number = (mouseX / width);
			if( x < 0.0 )		x = 0.0;
			else if( x > 1.0 )	x = 1.0;
			
			var y: Number = (mouseY / height);
			if( y < 0.0 )		y = 0.0;
			else if( y > 1.0 )	y = 1.0;
			
			if( _xPos != x ) {
				notifyPropertyChange( X_POS, _xPos, _xPos = x );
				updateLine();
			}
			if( _yPos != y ) {
				notifyPropertyChange( Y_POS, _yPos, _yPos = y );
				updateLine();
			}
			
			drag( select2D, stage );
		}
		
		private function updateLine() : void {
			_shape.x = _box.width * _xPos;
			_shape.y = _box.height * _yPos;
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
		
		public function get yPos(): Number {
			return _yPos;
		}
		
		[Observable]
		public function set yPos( yPos: Number) : void {
			if( _yPos != yPos ) {
				notifyPropertyChange( Y_POS, _yPos, _yPos = yPos );
				updateLine();
			}
		}
	}
}
import nanosome.util.access.qname;
const GRADIENT: QName = qname( "gradient" );
const X_POS: QName = qname( "xPos" );
const Y_POS: QName = qname( "yPos" );
const Z_POS: QName = qname( "zPos" );