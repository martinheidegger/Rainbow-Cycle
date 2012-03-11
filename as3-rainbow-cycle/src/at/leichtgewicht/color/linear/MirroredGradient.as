package at.leichtgewicht.color.linear {
	import flash.events.EventDispatcher;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class MirroredGradient extends EventDispatcher implements ILinearGradient {
		
		private var _gradient: ILinearGradient;
		
		public function MirroredGradient( gradient: ILinearGradient ) {
			_gradient = gradient;
		}
		
		public function getColor( percent: Number ): uint {
			return _gradient.getColor( ( percent < 0.5 ? percent : (1.0 - percent) ) * 2.0 );
		}
	}
}
