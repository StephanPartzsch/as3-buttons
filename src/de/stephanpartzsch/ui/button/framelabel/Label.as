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
package de.stephanpartzsch.ui.button.framelabel
{
	/**
	 * The <code>Label</code> stores data about the labels in a MovieClip. 
	 * It contains some different information than those which are stored in <code>FrameLabel</code>. 
	 * The first as well as the last frame can be found and also the number of frames that belong to this label is stored.
	 * 
	 * @see flash.display.FrameLabel
	 */
	public class Label
	{
		private var _startFrame : int;
		private var _endFrame : int;
		private var _length : int;

		/**
		 * Creates an instance of type <code>Label</code>.
		 * 
		 * @param startFrame The first frame of this label.
		 * @param endFrame The last frame of this label.
		 * 
		 * @throws ArgumentError If <code>startFrame</code> is bigger than the <code>endFrame</code>.
		 */
		public function Label( startFrame : int, endFrame : int )
		{
			if( endFrame < startFrame )
				throw new ArgumentError( "The end frame has to be a bigger number than the start frame!" );
			
			_startFrame = startFrame;
			_endFrame = endFrame;
			_length = endFrame - startFrame + 1;
		}

		/**
		 * Returns the first frame of this label.
		 *
		 * @return The first frame of this label.
		 */
		public function get startFrame() : int
		{
			return _startFrame;
		}

		/**
		 * Returns the last frame of this label.
		 *
		 * @return The last frame of this label.
		 */
		public function get endFrame() : int
		{
			return _endFrame;
		}

		/**
		 * Returns the length of this label.
		 *
		 * @return The number of frames that belong to this label.
		 */
		public function get length() : int
		{
			return _length;
		}
	}
}