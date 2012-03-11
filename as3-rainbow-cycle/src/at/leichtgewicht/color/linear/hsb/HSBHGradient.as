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
package at.leichtgewicht.color.linear.hsb {
	import at.leichtgewicht.color.linear.ILinearGradient;
	import at.leichtgewicht.color.util.HSBtoUint;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	/**
	 * <code>RainbowGradient</code> defines a gradient on a rainbow scale
	 * 
	 * @author Martin Heidegger
	 */
	public class HSBHGradient extends EventDispatcher implements ILinearGradient {
		
		// Brightness
		private var _brightness: Number;
		
		// Saturation
		private var _saturation: Number;
		
		/**
		 * Creates a new RainbowGradient
		 * 
		 * @param saturation Saturation value to be used. From 0=no saturation(grey) to 1=full saturation.
		 * @param brightness Brightness value to be used. From 0=black to 1=max brightness.
		 */
		public function HSBHGradient( saturation: Number, brightness: Number ) {
			_saturation = saturation;
			_brightness = brightness;
		}
		
		/**
		 * Calculates a RGB value basically using a HSB color space where the 
		 * hue receives a expansion by applying a Cosinus fuction to the under
		 * represented color areas. It will create a more homogenic spectrum than
		 * by just using the HSB method.
		 * 
		 * @param percentage Percentage to be used, similar to hue but with a Cosinus
		 *        shift.
		 */
		public function getColor( percentage: Number ): uint {
			return HSBtoUint( percentage * 360.0, _saturation, _brightness );
		}
		
		/**
		 * Brightness value to be used. From 0=black to 1=max brightness.
		 */
		[Bindable(event="change")]
		public function set brightness( brightness: Number ): void {
			if( _brightness != brightness ) {
				_brightness = brightness;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get brightness(): Number {
			return _brightness;
		}
		
		/**
		 *  Saturation value to be used. From 0=no saturation(grey) to 1=full saturation.
		 */
		[Bindable(event="change")]
		public function set saturation( saturation: Number ): void {
			if( _saturation != saturation ) {
				_saturation = saturation;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get saturation(): Number {
			return _saturation;
		}
	}
}
