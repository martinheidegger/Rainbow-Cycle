package colorEditor.view {
	import colorEditor.model.ThreeDProperty;
	import com.bit101.components.HUISlider;
	import com.bit101.components.RadioButton;
	import flash.events.Event;
	import nanosome.notify.observe.ObservableSprite;
	import nanosome.util.EnterFrame;
	import nanosome.util.access.qname;


	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class ColorPropertyEditor extends ObservableSprite {
		
		private static const Q_NAME : QName = qname("value");
		
		private var _slider: HUISlider;
		private var _radio: RadioButton;
		private var _selected: Boolean;
		private var _value : Number;
		private var _field : ThreeDProperty;
		
		public function ColorPropertyEditor( field: ThreeDProperty, value: Number ) {
			_field = field;
			_slider = new HUISlider(this, 20, 0, field.x.name.toString(), updateOnSliderChange);
			_slider.setSliderParams( field.x.from, field.x.to, value );
			_radio = new RadioButton( this, 0, 5, "", false, setSelected );
		}

		private function check() : void {
			value = _slider.value;
			EnterFrame.remove( check );
		}
		
		private function updateOnSliderChange( e: Event ): void {
			EnterFrame.add( check );
		}
		
		public function get field(): ThreeDProperty {
			return _field;
		}
		
		private function setSelected( e: Event ): void {
			if( _radio.selected ) {
				selected = true;
			}
		}
		
		[Observable]
		public function set value( value: Number ): void {
			if( value != _value ) {
				notifyPropertyChange( Q_NAME, _value, _slider.value = _value = value );
			}
		}
		
		public function get value(): Number {
			return _value;
		}
		
		public function get selected() : Boolean {
			return _radio.selected;
		}
		
		[Observable]
		public function set selected( selected: Boolean ): void {
			if( selected != _selected ) {
				notifyPropertyChange( qname("selected"), _selected, _radio.selected = _selected = selected );
			}
		}

		public function valuePerc( number: Number ): void {
			if( number < 0.0 )		number = 0.0;
			else if( number > 1.0 )	number = 1.0;
			
			value = number * ( _slider.maximum - _slider.minimum ) + _slider.minimum;
		}
	}
}
