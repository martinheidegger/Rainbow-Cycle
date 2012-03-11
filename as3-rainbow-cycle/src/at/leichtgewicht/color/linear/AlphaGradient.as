package at.leichtgewicht.color.linear {
	import flash.events.EventDispatcher;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class AlphaGradient extends EventDispatcher implements ILinearGradient {
		private var _gradient: ILinearGradient;
		private var _from: Number;
		private var _balance: Number;
		private var _diff: Number;
		private var _balanceInv: Number;
		
		public function AlphaGradient(gradient : ILinearGradient, from : Number = 0.0, to : Number = 1.0, balance: Number = 0.5 ) {
			_balance = balance;
			_balanceInv = 1.0 - balance;
			_diff = (to-from) * 255.0;
			_from = from * 255.0 << 24;
			_gradient = gradient;
		}
		
		public function getColor( percent: Number ): uint {
			if( percent < _balance ) {
				percent = percent / _balance * 0.5;
			} else {
				percent = 0.5 + ( percent - _balance ) / _balanceInv * 0.5;
			}
			var color: uint = _gradient.getColor( percent ) & 0xFFFFFF + _from;
			return color + ( _diff * percent << 24 );
		}
	}
}
