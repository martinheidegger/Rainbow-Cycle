package colorEditor {
	import at.leichtgewicht.color.linear.ILinearGradient;
	import at.leichtgewicht.color.dim2.I2DGradient;
	import colorEditor.model.ColorInfo;
	import colorEditor.model.LimitedProperty;
	import colorEditor.model.ThreeDProperty;
	import nanosome.notify.observe.IPropertyObserver;
	import nanosome.notify.observe.Observable;
	import nanosome.util.ChangedPropertyNode;
	import nanosome.util.pool.poolInstance;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class ColorEditorModel extends Observable implements IPropertyObserver {
		
		private var _color: ColorInfo;
		private var _selectedColor: ThreeDProperty;
		private var _x: Number;
		private var _y: Number;
		private var _z: Number;
		private var _gradient2D: I2DGradient;
		private var _gradient1D: ILinearGradient;
		
		public function ColorEditorModel( color: uint ) {
			this.color = new ColorInfo( color );
			this.selectedColor = ColorInfo.RED_3D;
		}
		
		public function get color(): ColorInfo {
			return _color;
		}
		
		[Observable]
		public function set color( color: ColorInfo ): void {
			if( color != _color ) {
				if( _color ) {
					_color.removePropertyObserver( this );
				}
				if( color ) {
					color.addPropertyObserver( this );
				}
				notifyPropertyChange( COLOR, _color, _color = color );
				updateProperties();
			}
		}
		
		private function updateProperties(): void {
			if( _selectedColor && _color ) {
				var old2D: I2DGradient = _gradient2D;
				var old1D: ILinearGradient = _gradient1D;
				_gradient2D = I2DGradient( poolInstance( _selectedColor.twoD ) );
				_gradient1D = ILinearGradient( poolInstance( _selectedColor.oneD ) );
				onPropertyChange( color, _selectedColor.x.name, null, null );
				onPropertyChange( color, _selectedColor.y.name, null, null );
				onPropertyChange( color, _selectedColor.z.name, null, null );
				notifyPropertyChange( GRADIENT_2D, old2D, _gradient2D );
				notifyPropertyChange( GRADIENT_1D, old1D, _gradient1D );
			}
		}
		
		public function get selectedColor(): ThreeDProperty {
			return _selectedColor;
	
		}
		
		[Observable]
		public function set selectedColor( selectedColor: ThreeDProperty ): void {
			if( _selectedColor != selectedColor ) {
				notifyPropertyChange( SELECTED_COLOR, _selectedColor, _selectedColor = selectedColor );
				updateProperties();
			}
		}
		
		[Observable]
		public function get x(): Number {
			return _x;
		}
		
		public function set x( x: Number ): void {
			if( _x != x ) {
				_gradient2D[ selectedColor.x.name ] = setValue( _selectedColor.x, x );
				notifyPropertyChange( X, _x, _x = x );
			}
		}
		
		[Observable]
		public function get y() : Number {
			return _y;
		}
		
		public function set y(y : Number) : void {
			if( _y != y ) {
				_gradient1D[ _selectedColor.y.name ] = setValue( _selectedColor.y, y );
				notifyPropertyChange( Y, _y, _y = y );
			}
		}
		
		[Observable]
		public function get z() : Number {
			return _z;
		}
		
		public function set z(z : Number) : void {
			if( _z != z ) {
				_gradient1D[ _selectedColor.z.name ] = setValue( _selectedColor.z, z );
				notifyPropertyChange( Z, _z, _z = z );
			}
		}
		
		public function onPropertyChange( observable: *, propertyName: QName, oldValue: *, newValue: * ): void {
			if( propertyName == _selectedColor.x.name ) {
				var x: Number = getValue( _selectedColor.x );
				_gradient2D[ _selectedColor.x.name ] = _color[ _selectedColor.x.name ];
				if( _x != x ) {
					notifyPropertyChange( X, _x, _x = x );
				}
			} else if( propertyName == _selectedColor.y.name ) {
				var y: Number = getValue( _selectedColor.y );
				_gradient1D[ _selectedColor.y.name ] = _color[ _selectedColor.y.name ];
				if( _y != y ) {
					notifyPropertyChange( Y, _y, _y = y );
				}
			} else if( propertyName == _selectedColor.z.name ) {
				var z: Number = getValue( _selectedColor.z ); 
				_gradient1D[ _selectedColor.z.name ] = _color[ _selectedColor.z.name ];
				if( _z != z ) {
					notifyPropertyChange( Z, _z, _z = z );
				}
			}
		}
		
		private function setValue( prop: LimitedProperty, val: Number ): Number {
			return _color[ prop.name ] = val * prop.diff + prop.from;
		}
		
		private function getValue( prop: LimitedProperty ): Number {
			return ( _color[ prop.name ] - prop.from ) / prop.diff;
		}
		
		[Observable]
		public function get gradient2D(): I2DGradient {
			return _gradient2D;
		}
		
		[Observable]
		public function get gradient1D(): ILinearGradient {
			return _gradient1D;
		}
		
		public function onManyPropertiesChanged( observable: *, changes: ChangedPropertyNode ): void {
			while( changes ) {
				onPropertyChange( observable, changes.name, changes.oldValue, changes.newValue );
				changes = changes.next;
			}
		}
	}
}
import nanosome.util.access.qname;

const COLOR: QName = qname( "color" );
const SELECTED_COLOR: QName = qname( "selectedColor" );
const GRADIENT_2D: QName = qname("gradient2D");
const GRADIENT_1D: QName = qname("gradient1D");
const X: QName = qname("x");
const Y: QName = qname("y");
const Z: QName = qname("z");