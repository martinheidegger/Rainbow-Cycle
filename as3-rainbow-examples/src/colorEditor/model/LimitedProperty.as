package colorEditor.model {
	import nanosome.util.access.qname;
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public class LimitedProperty {
		
		public var name: QName;
		public var from: Number;
		public var to: Number;
		public var diff: Number;

		public function LimitedProperty(name : String, from : Number, to : Number) {
			this.to = to;
			this.from = from;
			this.diff = to-from;
			this.name = qname( name );
		}
		
		public function toString(): String {
			return name.toString();
		}
	}
}
