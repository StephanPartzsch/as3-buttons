/**
 * Copyright (c) 2012 Stephan Partzsch
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *  
 * @author Stephan Partzsch
 * http://www.stephan-partzsch.de
 */
package de.stephanpartzsch.ui.button.framelabel.enum
{
	/**
	 * String constants that are used to reflect the label names which are used in <code>FrameButton</code> and <code>ToggleFrameButton</code> instances.
	 */
	public class LabelName
	{		
		/**
		 * Reflects the 'normal' button state when it is active and when no mouse interaction happens.
		 */
		public static const DEFAULT : String = "default";
		
		/**
		 * Reflects the button state when the mouse moves over the button.
		 */
		public static const OVER : String = "over";
		
		/**
		 * Reflects the button state when the mouse moves out of the button.
		 */
		public static const OUT : String = "out";
		
		/**
		 * Reflects the button state when the button gets clicked.
		 */
		public static const CLICK : String = "click";
		
		/**
		 * Reflects the button state when the button is disabled/inactive.
		 */
		public static const DISABLED : String = "disabled";
		
		/**
		 * Reflects the 'normal' button state when it is active and when no mouse interaction happens. 
		 * But it is only used if the button is selected! (only used for <code>ToggleFrameButton</code>)
		 */
		public static const SELECTED_DEFAULT : String = "selected_default";
		
		/**
		 * Reflects the button state when the mouse moves over the button.
		 * But it is only used if the button is selected! (only used for <code>ToggleFrameButton</code>)
		 */
		public static const SELECTED_OVER : String = "selected_over";
		
		/**
		 * Reflects the button state when the mouse moves out of the button.
		 * But it is only used if the button is selected! (only used for <code>ToggleFrameButton</code>)
		 */
		public static const SELECTED_OUT : String = "selected_out";
		
		/**
		 * Reflects the button state when the button gets clicked.
		 * But it is only used if the button is selected! (only used for <code>ToggleFrameButton</code>)
		 */
		public static const SELECTED_CLICK : String = "selected_click";
		
		/**
		 * Reflects the button state when the button is disabled/inactive.
		 * But it is only used if the button is selected! (only used for <code>ToggleFrameButton</code>)
		 */
		public static const SELECTED_DISABLED : String = "selected_disabled";
	}
}