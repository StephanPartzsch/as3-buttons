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
package de.stephanpartzsch.ui.button.labeltext
{
	import de.stephanpartzsch.ui.button.event.FrameButtonEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * The <code>LabelTextController</code> is used to control a text field
	 * as a label of a given MovieClip.
	 * 
	 * <p>The TextField has to have the name <b>labelText</b>. It is possible to place 
	 * this TextField directly on the timeline or wrap it in an other MovieClip named 
	 * <b>textContainer</b>.</p>
	 * <p>Moreover the label text can be centered vertically, if the text field is bigger
	 * than required.</p>
	 */
	public class LabelTextController
	{
		private var movieClip : MovieClip;
		private var label : String;
		private var centerTextVertically : Boolean;

		/**
		 * Creates a new instance of type <code>LabelTextController</code>.
		 * 
		 * @param movieClip	The MovieClip instance that contains the text field that is to be controlled.
		 * @param label The label text that is to be used in the text field of <code>movieClip</code>.
		 * @param centerTextVertically Whether or not the label text is to be centered vertically. Default is <code>false</code>.
		 * 
		 * @throws ReferenceError If no text field can be found in the given MovieClip instance.
		 */
		public function LabelTextController( movieClip : MovieClip, label : String = "", centerTextVertically : Boolean = false )
		{
			this.label = label;
			this.movieClip = movieClip;
			this.centerTextVertically = centerTextVertically;

			initialize();
		}
		
		/**
		 * Disposes the LabelTextController.
		 * <p>It cleans up everything and makes the LabelTextController ready for 
		 * Garbage Collection.</p>
		 */
		public function dispose() : void
		{
			removeEventListener();
			movieClip = null;
		}

		private function initialize() : void
		{
			if ( !hasLabel )
				return;

			addEventListener();
			updateLabel();
		}

		private function get hasLabel() : Boolean
		{
			return label != "" && labelTextField != null;
		}

		private function get labelTextField() : TextField
		{
			if ( movieClip["labelText"] as TextField != null )
				return movieClip["labelText"] as TextField;
			else if ( movieClip["textContainer"] && movieClip["textContainer"]["labelText"] )
				return movieClip["textContainer"]["labelText"] as TextField;

			throw new ReferenceError( "No text field could be found with the name 'labelText'. Place it either directly on the timeline or wrap it in an other MovieClip named 'textContainer'." );
		}

		private function addEventListener() : void
		{
			movieClip.addEventListener( MouseEvent.ROLL_OVER, handleButtonInteraction );
			movieClip.addEventListener( MouseEvent.ROLL_OUT, handleButtonInteraction );
			movieClip.addEventListener( MouseEvent.MOUSE_DOWN, handleButtonInteraction );
			movieClip.addEventListener( MouseEvent.MOUSE_UP, handleButtonInteraction );
			movieClip.addEventListener( FrameButtonEvent.DISABLED, handleButtonInteraction );
			movieClip.addEventListener( FrameButtonEvent.ENABLED, handleButtonInteraction );
		}

		private function removeEventListener() : void
		{
			movieClip.removeEventListener( MouseEvent.ROLL_OVER, handleButtonInteraction );
			movieClip.removeEventListener( MouseEvent.ROLL_OUT, handleButtonInteraction );
			movieClip.removeEventListener( MouseEvent.MOUSE_DOWN, handleButtonInteraction );
			movieClip.removeEventListener( MouseEvent.MOUSE_UP, handleButtonInteraction );
			movieClip.removeEventListener( FrameButtonEvent.DISABLED, handleButtonInteraction );
			movieClip.removeEventListener( FrameButtonEvent.ENABLED, handleButtonInteraction );
		}

		private function handleButtonInteraction( event : Event ) : void
		{
			updateLabel();
		}

		private function updateLabel() : void
		{
			labelTextField.htmlText = label;

			if ( centerTextVertically )
				labelTextField.y += Math.round( ( labelTextField.height - labelTextField.textHeight ) * 0.5 );
		}
	}
}