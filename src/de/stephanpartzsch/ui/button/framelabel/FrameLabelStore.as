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
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	/**
	 * The <code>FrameLabelStore</code> collects every <code>FrameLabel</code> from a given MovieClip instance and stores them as a collection of <code>Label</code>s.
	 * 
	 * @see flash.display.FrameLabel
	 */
	public class FrameLabelStore
	{
		private var labels : Dictionary;

		/**
		 * Creates a new instance of <code>FrameLabelStore</code> and directly collects every <code>FrameLabel</code> from a given MovieClip instance.
		 * 
		 * @param movieClip The MovieClip instance from which every <code>FrameLabel</code> is retrieved. 
		 * 
		 * @throws ArgumentError If the given MovieClip instance is <code>null</code>
		 */
		public function FrameLabelStore( movieClip : MovieClip )
		{
			if( movieClip == null )
				throw new ArgumentError( "FrameLabelStore has to be initialized with a non null and valid instance of type MovieClip." );
			
			labels = new Dictionary();
			storeAllFrameLabels( movieClip );
		}

		/**
		 * Returns the <code>Label</code> out of the collection that belongs to the given labelName.
		 * 
		 * @param labelName The name of the <code>Label</code> that should be returned.
		 *
		 * @return The <code>Label</code> out of the collection that belongs to the given labelName.
		 * 
		 * @throws ArgumentError If no <code>Label</code> could be found for the given labelName.
		 */
		public function getLabelForName( labelName : String ) : Label
		{
			if( !doesLabelExistForName( labelName ) )
				throw new ArgumentError( "A label with the name {0} does not exit for the MovieClip of this FrameButton.", labelName );
			
			return labels[labelName];
		}

		/**
		 * Checks whether or not a <code>Label</code> with the given labelName exists in the collection.
		 * 
		 * @param labelName The name of the <code>Label</code> that should be checked for existenz.
		 *
		 * @return Whether or not a <code>Label</code> with the given labelName exists in the collection.
		 */
		public function doesLabelExistForName( labelName : String ) : Boolean
		{
			return labels[labelName] != null;
		}

		/**
		 * Returns a <code>Dictionary</code> with all <code>Label</code> objects. 
		 * The name of the <code>Label</code>/<code>FrameLabel</code> is used as the key and the <code>Label</code> object represents the value. 
		 *
		 * @return All <code>Label</code> objects.
		 */
		public function getAllLabels() : Dictionary
		{
			return labels;
		}
		
		/**
		 * Disposes the <code>FrameLabelStore</code> and resets the collection of <code>Label</code> objects.
		 */	
		public function dispose() : void
		{
			labels = null;
		}

		private function storeAllFrameLabels( movieClip : MovieClip ) : void
		{
			var frameLabel : FrameLabel;
			var frameLabels : Array = movieClip.currentLabels;
			var frameLabelEnd : int = movieClip.totalFrames;
			
			for( var i : int = frameLabels.length-1; i >= 0; i-- ) 
			{
				frameLabel = frameLabels[i];
				
				addFrameLabel( frameLabel.name, frameLabel.frame, frameLabelEnd );
				
				frameLabelEnd = frameLabel.frame - 1;
			}
		}

		private function addFrameLabel( labelName : String, startFrame : int, endFrame : int ) : void
		{
			labels[labelName] = new Label( startFrame, endFrame );
		}
	}
}