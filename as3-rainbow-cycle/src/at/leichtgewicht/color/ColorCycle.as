//  
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License. 
//  
package at.leichtgewicht.color {
	
	import at.leichtgewicht.color.linear.ILinearGradient;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	/**
	 * <code>ColorFade</code> is a class to handle a periodical, synchronized
	 * and natural change of the color based to the systems time.
	 * 
	 * <p>If you instanciate <code>ColorFade</code> you have to pass a <code>Stage</code>
	 * instance that serves as eventsource for the <code>onEnterframe</code>
	 * event, which is the basic for the changing of the color.</p>
	 * 
	 * <p>The color will be generated using <code>RainbowColor</code> with using
	 * the current systems time in milliseconds, transformed by a passed-in
	 * <code>cycle</code> that will be used as percentage.</p>
	 * 
	 * <p>With this mechanism it is possible to have the color synchronized through
	 * many flash players or even other progamming enviroments like JavaScript.</p>
	 * 
	 * <p>Note: If noone registers to the instance, it will not add itself
	 * as listener and if you remove all instances it will remove itself as a
	 * listener.</p>
	 * 
	 * @author Martin Heidegger
	 * @version 1.0
	 * 
	 * @see RainbowColor
	 */
	public class ColorCycle
	{
		// Instance of colorTransform. Used to replace the register objects
		// colorTransform
		private var _colorTransform: ColorTransform;
		
		// Cycle in which the color will be changed
		private var _cycle: uint;
		
		// Internal holder for the registered <code>DisplayObject</code>'s
		private var _registered: Array;
		
		// Gradient to be used to render the color
		private var _gradient: ILinearGradient;
		
		/**
		 * Constructs a new ColorFade instance.
		 * 
		 * @param stage Stage to register onEnterFrame events to.
		 * @param cycle Cycle in which one rainbow should be run through.
		 * @param gradient Gradient to be used for the cycle
		 */
		public function ColorCycle( cycle: int, gradient: ILinearGradient )
		{
			_colorTransform = new ColorTransform( 0, 0, 0, 1 );
			_gradient = gradient;
			this.cycle = cycle;
		}
		
		/**
		 * @return The current percentage used for the <code>RainbowColor</code>.
		 */
		public function get currentPercentage(): Number
		{
			var time: Number = ( new Date() ).getTime();
			return ( time % cycle ) / cycle;
		}
		
		/**
		 * @return the current color to be used as number.
		 */
		public function get currentColor(): uint
		{
			return _gradient.getColor( currentPercentage );
		}
		
		/**
		 * @return The current used <code>ColorTransform</code> instance that
		 *         is used to replace the members of the registered classes.
		 */
		public function get colorTransform(): ColorTransform
		{
			return _colorTransform;
		}
		
		/**
		 * Method to register a <code>DisplayObject</code> that should be modified
		 * periodically.
		 * 
		 * <p>If you register a  <code>DisplayObject</code> the 
		 * <code>.transform.colorTransform</code> member will be <b>replaced</b>
		 * on every <code>Event.ENTER_FRAME</code>.</p>
		 * 
		 * @param displayObject <code>DisplayObject</code> to be registered for replacment.
		 */
		public function register( displayObject: DisplayObject ): void
		{
			if( null == _registered )
			{
				_registered = [ displayObject ];
				_eventProvider.addEventListener( Event.ENTER_FRAME, onEnterframe, false, 0, true );
				onEnterframe();
			}
			else
			if( _registered.indexOf( displayObject ) == -1 )
			{
				_registered.push( displayObject );
				displayObject.transform.colorTransform = _colorTransform;
			}
		}
		
		/**
		 * Unregisters a <code>DisplayObject</code> that was registered by
		 * using <code>register</code>.
		 * 
		 * @param displayObject <code>DisplayObject</code> to be unregistered.
		 * @see #register
		 */
		public function unregister( displayObject: DisplayObject ): void
		{
			if( null != _registered )
			{
				var index: int = _registered.indexOf( displayObject );
				if( index >= 0 )
				{
					_registered.splice( index, 1 );
				}
				if( _registered.length == 0 )
				{
					_eventProvider.removeEventListener( Event.ENTER_FRAME, onEnterframe );
					_registered = null;
				}
			}
		}
		
		/**
		 * Disposer to clean up the instance.
		 * 
		 * <p>This method will remove even the slightest trace of the instance.
		 * After calling this the instance will not work anymore!</p>
		 */
		public function dispose(): void
		{
			_eventProvider.removeEventListener( Event.ENTER_FRAME, onEnterframe );
			_registered = null;
			_colorTransform = null;
		}
		public function get cycle(): uint
		{
			return _cycle;
		}
		
		/**
		 * Cycle duration of the the color change.
		 * 
		 * <p>The cycle defines the range in milliseconds in which the complete
		 * rainbow should be passed.</p>
		 * 
		 * <p>A change of this value will be applied within the next
		 * <code>Event.ENTER_FRAME</code>.</p>
		 * 
		 * @param cycle cycle in milliseconds.
		 */
		public function set cycle( cycle: uint  ): void
		{
			_cycle = cycle;
		}
		
		/**
		 * Handles a <code>Event.ENTER_FRAME</code> and replaces all
		 * <code>colorTransform</code> objects.
		 * 
		 * @param event Event that is passed by the <code>EventDispatcher</code>
		 * @see #register
		 */
		protected function onEnterframe( event: Event = null ): void
		{
			_colorTransform.color = currentColor;
			
			var i: int = _registered.length;
			while( --i-(-1) )
			{
				DisplayObject( _registered[ i ] ).transform.colorTransform = _colorTransform;
			}
		}
		
		public function get gradient(): ILinearGradient {
			return _gradient;
		}
		
		public function set gradient( gradient: ILinearGradient ): void {
			_gradient = gradient;
		}
	}
}
import flash.display.Shape;

// Instance of a Shape that provides a enterframe event
const _eventProvider: Shape = new Shape();