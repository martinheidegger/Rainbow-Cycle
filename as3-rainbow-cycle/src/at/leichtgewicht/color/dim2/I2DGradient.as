package at.leichtgewicht.color.dim2 {
	
	import flash.display.Shader;
	import flash.events.IEventDispatcher;
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public interface I2DGradient extends IEventDispatcher {
		
		function get shader(): Shader;
		function getColor( yPercent: Number, zPercent: Number ): uint;
	}
}
