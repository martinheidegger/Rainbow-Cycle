package at.leichtgewicht.color.linear {
	import flash.events.EventDispatcher;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class GradientRange extends EventDispatcher implements ILinearGradient {
		
		private var _gradient : ILinearGradient;
		private var _from: Number;
		private var _diff: Number;
		
		public function GradientRange( gradient: ILinearGradient, from: Number = 0.0, to: Number = 0.0 ) {
			_gradient = gradient;
			_from = from;
			_diff = to-from;
		}
		
		public function getColor( percent: Number ): uint {
			percent = _from + _diff * percent;
			while( percent < 0 ) {
				percent += 1.0;
			}
			while( percent > 1.0 ) {
				percent -= 1.0;
			}
			return _gradient.getColor( percent );
		}
	}
}
