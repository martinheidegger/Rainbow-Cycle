package colorEditor.model {
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class ThreeDProperty {
		public var x: LimitedProperty;
		public var y : LimitedProperty;
		public var z : LimitedProperty;
		public var oneD : Class;
		public var twoD : Class;
		
		public function ThreeDProperty( x: LimitedProperty, y: LimitedProperty, z: LimitedProperty, oneD: Class, twoD: Class ) {
			this.twoD = twoD;
			this.oneD = oneD;
			this.z = z;
			this.y = y;
			this.x = x;
		}
	}
}
