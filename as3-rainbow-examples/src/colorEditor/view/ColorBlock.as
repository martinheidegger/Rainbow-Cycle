package colorEditor.view {
	import nanosome.notify.observe.ObservableSprite;
	import nanosome.util.access.qname;
	
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class ColorBlock extends ObservableSprite {
		
		private var _color: uint;
		
		public function get color(): uint {
			return _color;
		}
		
		[Observable]
		public function set color( color: uint ): void {
			if( _color != color ) {
				graphics.clear();
				graphics.beginFill( color );
				graphics.drawRect( 0, 0, 40, 40 );
				notifyPropertyChange( qname( color ), _color, _color = color );
			}
		}
	}
}
