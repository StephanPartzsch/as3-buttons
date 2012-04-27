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
package de.stephanpartzsch.ui.button.error
{
	import flash.display.MovieClip;
	
	/**
	 * The MissingLabelError class represents an error that occurs if a type of FrameButton is instantiated with a MovieClip instance, that does not contain the required labels.
	 * It creates an error message which looks like this: <code>One of the required frame labels (...) is missing for the button instance (...) of type FrameButton</code>.
	 */
	public class MissingLabelError extends Error
	{
		private var _buttonInstance : MovieClip;

		/**
		 * Creates an instance of the class MissingLabelError.
		 * 
		 * @param requiredLabelNames The required label names. One of these is missing for the given button instance (MovieClip).
		 * @param buttonInstance The button instance where one or more label names are missing.
		 * @param id (Optional) Id of the error object.
		 */
		public function MissingLabelError( requiredLabelNames : Array, buttonInstance : MovieClip, id : * = 0 )
		{
			_buttonInstance = buttonInstance;
			
			var message : String = "One of the required frame labels (" + requiredLabelNames.join( ", " ) + ") is missing for the button instance (" + buttonInstance + ") of type FrameButton";
			super( message, id );
		}

		/**
		 * Returns the button instance where one or more label names are missing.
		 * 
		 * @return The button instance where one or more label names are missing.
		 */
		public function get buttonInstance() : MovieClip
		{
			return _buttonInstance;
		}
	}
}