package colorEditor.view {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class InteractiveOverlay extends Sprite {
		private var _target: DisplayObject;
		
		public function InteractiveOverlay( forObject: DisplayObject, customWidth: Number = 0.0, customHeight: Number = 0.0 ) {
			_target = forObject;
			x = forObject.x;
			y = forObject.y;
			graphics.beginFill( 0xFFFFFF, 0.0 );
			graphics.drawRect( 0, 0, customWidth || forObject.width, customHeight || forObject.height );
			rotation = _target.rotation;
			mouseEnabled = true;
			mouseChildren = false;
			buttonMode = true;
		}
		
		public function get target(): DisplayObject {
			return _target;
		}
	}
}
