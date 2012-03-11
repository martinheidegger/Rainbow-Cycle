package colorEditor {
	import colorEditor.model.ColorInfo;
	import colorEditor.model.ThreeDProperty;
	import colorEditor.view.ColorBlock;
	import colorEditor.view.ColorPropertyEditor;
	import colorEditor.view.Gradient1DLine;
	import colorEditor.view.Gradient2DBox;

	import nanosome.notify.bind.bind;
	import nanosome.notify.bind.impl.WatchField;
	import nanosome.notify.bind.path;
	import nanosome.notify.bind.watch;

	import com.bit101.components.Text;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.ContextMenu;
	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class ColorEditor extends Sprite {
		
		private var _2DBox: Gradient2DBox;
		private var _1DLine: Gradient1DLine;
		private var _colorBox: ColorBlock;
		private var _hexInput: Text;
		
		private var _propertyEditors: Vector.<ColorPropertyEditor> = new Vector.<ColorPropertyEditor>();
		private var _selectedProperty: ColorPropertyEditor;
		
		private var _nextEditorYPosition: Number = 0.0;
		
		private var _model: ColorEditorModel;
		
		public function ColorEditor() {
			
			// Initializing
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var cm: ContextMenu = new ContextMenu( );
			cm.hideBuiltInItems();
			
			contextMenu = cm;
			
			_model = new ColorEditorModel( 0xFF0000 );
			
			var top: Number = 50;
			
			addChild( _hexInput = new Text() );
			_hexInput.y = 5;
			_hexInput.x = 50;
			_hexInput.width = 80;
			_hexInput.height = 20;
			bind( _model, "color.hex", _hexInput, "text" );
			
			addChild( _colorBox = new ColorBlock() );
			_colorBox.x = 5;
			_colorBox.y = 5;
			bind( _model, "color.rgb", _colorBox, "color" );
			
			addChild( _2DBox = new Gradient2DBox() );
			_2DBox.x = 5;
			_2DBox.y = top;
			bind( _model, "gradient2D",	_2DBox, "gradient" );
			bind( _model, "y",			_2DBox, "xPos" );
			bind( _model, "z",			_2DBox, "yPos" );
			
			addChild( _1DLine = new Gradient1DLine() );
			_1DLine.x = 256+25+5+5;
			_1DLine.y = top;
			_1DLine.rotation = 90;
			bind( _model, "gradient1D",	_1DLine, "gradient" );
			bind( _model, "x",			_1DLine, "xPos" );
			
			_nextEditorYPosition = top;
			
			var propertyGroupDistance: Number = 8;
			
			addPropEditor( ColorInfo.RED_3D, true );
			addPropEditor( ColorInfo.GREEN_3D );
			addPropEditor( ColorInfo.BLUE_3D );
			
			_nextEditorYPosition += propertyGroupDistance;
			
			addPropEditor( ColorInfo.HUE_3D );
			addPropEditor( ColorInfo.SATURATION_3D );
			addPropEditor( ColorInfo.BRIGHTNESS_3D );
			
			_nextEditorYPosition += propertyGroupDistance;
			
			addPropEditor( ColorInfo.LAB_L_3D );
			addPropEditor( ColorInfo.LAB_A_3D );
			addPropEditor( ColorInfo.LAB_B_3D );
			
			_nextEditorYPosition += propertyGroupDistance;
			
			addPropEditor( ColorInfo.SUB_RED_3D );
			addPropEditor( ColorInfo.SUB_YELLOW_3D );
			addPropEditor( ColorInfo.SUB_BLUE_3D );
		}
		
		private function addPropEditor( field: ThreeDProperty, selected: Boolean = false ): ColorPropertyEditor {
			var name: QName = field.x.name;
			var editor: ColorPropertyEditor = new ColorPropertyEditor( field, _model.color[ name ] );
			editor.x = 302.0;
			editor.y = _nextEditorYPosition;
			_nextEditorYPosition += 19;
			addChild( editor );
			
			if( selected ) {
				editor.selected = true;
				_selectedProperty = editor;
			}
			
			watch( editor, "selected" ).listen( selectProperty );
			bind ( _model, path( "color", name ), editor, "value" );
			
			_propertyEditors.push( editor );
			return editor;
		}
		
		private function selectProperty( field: WatchField, oldValue: *, newValue: * ): void {
			oldValue;
			if( field.object && newValue && _selectedProperty != field.object ) {
				if( _selectedProperty ) {
					_selectedProperty.selected = false;
				}
				_selectedProperty = ColorPropertyEditor( field.object );
				_model.selectedColor = _selectedProperty.field;
			}
		}
	}
}
