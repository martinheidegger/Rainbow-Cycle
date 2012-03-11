package at.leichtgewicht.color.linear {
	
	import flash.events.EventDispatcher;
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class BalancedGradient extends EventDispatcher implements ILinearGradient {
		
		private var _gradient: ILinearGradient;
		private var _balancing : Number;
		private var _balancingInv : Number;
		
		public function BalancedGradient( gradient: ILinearGradient, balancing: Number = 0.5 ) {
			_gradient = gradient;
			_balancing = balancing;
			_balancingInv = 1.0-balancing;
		}
		
		public function getColor( percent: Number ): uint {
			if( percent < _balancing ) {
				return _gradient.getColor( percent / _balancing * 0.5 );
			} else {
				return _gradient.getColor( 0.5 + ( percent - _balancing ) / _balancingInv * 0.5 );
			}
		}
	}
}
