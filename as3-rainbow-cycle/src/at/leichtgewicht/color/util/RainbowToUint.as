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
package at.leichtgewicht.color.util {
	
	/**
	 * Calculates a RGB value basically using a HSB color space where the 
	 * hue receives a expansion by applying a Cosinus fuction to the under
	 * represented color areas. It will create a more homogenic spectrum than
	 * by just using the HSB method.
	 * 
	 * @param percentage Percentage to be used, similar to hue but with a Cosinus
	 *        shift.
	 * @param saturation Saturation value to be used. From 0=no saturation(grey) to 1=full saturation.
	 * @param brightness Brightness value to be used. From 0=black to 1=max brightness.
	 * @author Martin Heidegger mh@leichtgewicht.at
	 */
	public function RainbowToUint( percentage: Number, saturation: Number, brightness: Number ): uint {
		var degree: Number = percentage * 1080;
		degree += 180;
		var degreeOffset: int = int( degree / 360 );
		degree = degree % 360;
		var offset: Number = -Math.cos( degree / 360 * Math.PI );
		return HSBtoUint(( degreeOffset * 360 + 180 * offset ) / 1080 * 360, saturation, brightness );
	}
}
