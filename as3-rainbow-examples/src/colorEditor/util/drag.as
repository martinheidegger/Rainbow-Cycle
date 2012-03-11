package colorEditor.util {
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public function drag( fnc: Function, stage: Stage ): void {
		stage.addEventListener( MouseEvent.MOUSE_MOVE, fnc, false, 0, true );
		stage.addEventListener( MouseEvent.MOUSE_UP, function( e: Event ): void {
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, fnc );
			stage.removeEventListener( MouseEvent.MOUSE_UP, arguments["callee"] );
		}, false, 0, true);
	}
}
