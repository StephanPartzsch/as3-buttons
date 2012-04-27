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
package de.stephanpartzsch.ui.button.label
{
	import de.stephanpartzsch.ui.button.event.FrameLabelEvent;

	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * Dispatched when the first frame of a <code>FrameLabel</code> is reached.
	 *
	 * @eventType de.stephanpartzsch.ui.button.event.FrameLabelEvent.FRAME_LABEL_START
	*/
	[Event(name="frame_label_start", type="de.stephanpartzsch.ui.button.event.FrameLabelEvent")]
	
	/**
	 * Dispatched when the last frame of a <code>FrameLabel</code> is reached.
	 *
	 * @eventType de.stephanpartzsch.ui.button.event.FrameLabelEvent.FRAME_LABEL_END
	*/
	[Event(name="frame_label_end", type="de.stephanpartzsch.ui.button.event.FrameLabelEvent")]
	
	/**
	 * The <code>FrameLabelController</code> controls the <code>FrameLabel</code> occurences of a given MovieClip instance. 
	 * 
	 * <p>This controller works close together with <code>FrameLabelStore</code> and is able 
	 * to check the existenz of a specific <code>Label</code>, and dispatches an event if the 
	 * first or last frame of a <code>Label</code> is reached.</p>
	 * <p>Furthermore this controller is able to set the playhead of the given MovieClip instance to a specific <code>Label</code> 
	 * or to start playing from the appropriate frame (in a different label) that fits to the current frame.</p>
	 */
	public class FrameLabelController extends EventDispatcher
	{
		private var movieClip : MovieClip;
		private var frameLabelStore : FrameLabelStore;

		/**
		 * Creates a new instance of <code>FrameLabelController</code>.
		 * 
		 * @param movieClip The MovieClip instance whose <code>FrameLabel</code>s will be controlled. 
		 * 
		 * @throws ArgumentError If the given MovieClip instance is <code>null</code>
		 */
		public function FrameLabelController( movieClip : MovieClip )
		{
			if ( movieClip == null )
				throw new ArgumentError( "FrameLabelController has to be initialized with a non null and valid instance of type MovieClip." );

			this.movieClip = movieClip;
			initialize();
		}
		
		/**
		 * Checks whether or not a <code>Label</code> with the given labelName exists.
		 * 
		 * @param labelName The name of the <code>Label</code> that should be checked for existenz.
		 *
		 * @return Whether or not a <code>Label</code> with the given labelName exists.
		 */
		public function doesLabelExistForName( labelName : String ) : Boolean
		{
			return frameLabelStore.doesLabelExistForName( labelName );
		}

		/**
		 * Sets the playhead to the last frame of the <code>Label</code> for the given labelName and stops it there.
		 * 
		 * @param labelName The name of the target <code>Label</code>.
		 * @param fallbackLabel (Optional) The <code>Label</code> that will be the target if no <code>Label</code> could be found for labelName.
		 */
		public function gotoAndStop( labelName : String, fallbackLabelName : String = "" ) : void
		{
			var nextLabel : Label = getNextLabel( labelName, fallbackLabelName );
			movieClip.gotoAndStop( calculateNextStopFrame( nextLabel ) );
		}

		/**
		 * Sets the playhead to the appropriate frame of the <code>Label</code> for the given labelName and continues playing.
		 * 
		 * <p>The target frame in the new <code>Label</code> is calculated by the first frame of the new <code>Label</code>
		 * plus the number of frames that correspond percentaged to the number of frames that are left over in the current <code>Label</code>.</p>
		 * 
		 * @param labelName The name of the target <code>Label</code>.
		 * @param fallbackLabel (Optional) The <code>Label</code> that will be the target if no <code>Label</code> could be found for labelName.
		 */
		public function gotoAndPlay( labelName : String, fallbackLabelName : String = "" ) : void
		{
			var nextLabel : Label = getNextLabel( labelName, fallbackLabelName );

			if( nextLabel.length == 1 )
				movieClip.gotoAndStop( nextLabel.endFrame );
			else
				movieClip.gotoAndPlay( calculateNextPlayFrame( nextLabel ) );
		}

		/**
		 * Disposes the <code>FrameLabelController</code>.
		 */
		public function dispose() : void
		{
			removeFrameScripts( frameLabelStore.getAllLabels() );
			disposeFrameLabelStore();
			disposeMovieClip();
		}
		
		private function initialize() : void
		{
			frameLabelStore = new FrameLabelStore( movieClip );
			addFrameScripts( frameLabelStore.getAllLabels() );
		}

		private function addFrameScripts( allLabels : Dictionary ) : void
		{
			for each ( var label : Label in allLabels )
				addFrameScriptForLabel( label );
		}
		
		private function addFrameScriptForLabel( label : Label ) : void
		{
			movieClip.addFrameScript( label.startFrame - 1, handleFrameLabelStart );

			if ( label.length > 1 )
				movieClip.addFrameScript( label.endFrame - 1, handleFrameLabelEnd );
		}

		private function handleFrameLabelStart() : void
		{
			dispatchEvent( new FrameLabelEvent( FrameLabelEvent.FRAME_LABEL_START, movieClip.currentLabel ) );
		}

		private function handleFrameLabelEnd() : void
		{
			dispatchEvent( new FrameLabelEvent( FrameLabelEvent.FRAME_LABEL_END, movieClip.currentLabel ) );
		}
		
		private function getNextLabel( labelName : String, fallbackLabelName : String ) : Label
		{
			var nextLabel : Label;

			if ( !doesLabelExistForName( labelName ) && fallbackLabelName != "" )
				nextLabel = frameLabelStore.getLabelForName( fallbackLabelName );
			else
				nextLabel = frameLabelStore.getLabelForName( labelName );
				
			return nextLabel;
		}
				
		private function removeFrameScripts( allLabels : Dictionary ) : void
		{
			for each ( var label : Label in allLabels )
				removeFrameScriptForLabel( label );
		}

		private function removeFrameScriptForLabel( label : Label ) : void
		{
			movieClip.addFrameScript( label.startFrame - 1, null );

			if ( label.length > 1 )
				movieClip.addFrameScript( label.endFrame - 1, null );
		}
		
		private function disposeMovieClip() : void
		{
			frameLabelStore.dispose();
			frameLabelStore = null;
		}

		private function disposeFrameLabelStore() : void
		{
			movieClip = null;
		}
		
		private function calculateNextStopFrame( nextLabel : Label ) : int
		{
			return nextLabel.endFrame;
		}

		private function calculateNextPlayFrame( nextLabel : Label ) : int
		{
			var nextFrame : int = 0;
			var currentLabel : Label = frameLabelStore.getLabelForName( movieClip.currentLabel );
			
			switch( true )
			{
				case currentLabel == nextLabel:
					nextFrame = currentLabel.startFrame;
					break;
				
				case !currentFrameIsInsideLabel( currentLabel ):
					nextFrame = nextLabel.startFrame;
					break;
				
				case currentLabel.length <= 1:
					nextFrame = nextLabel.startFrame;
					break;
				
				default:
					nextFrame = getAppropriateFrameInNextLabel( currentLabel, nextLabel );
			}
			
			return nextFrame;
		}

		private function currentFrameIsInsideLabel( currentLabel : Label ) : Boolean
		{
			var currentFrame : int = movieClip.currentFrame;
			return currentFrame >= currentLabel.startFrame && currentFrame <= currentLabel.endFrame;
		}

		private function getAppropriateFrameInNextLabel( currentLabel : Label, nextLabel : Label ) : int
		{
			var framesLeftInCurrentLabel : int = currentLabel.length - ( movieClip.currentFrame - currentLabel.startFrame );
			var percentageOfFramesLeft : Number = framesLeftInCurrentLabel / currentLabel.length;
			var playedNextFrames : int = Math.round( nextLabel.length * percentageOfFramesLeft ) - 1;
			
			if( playedNextFrames < 0 ) 
				playedNextFrames = 0; 

			return nextLabel.startFrame + playedNextFrames;
		}
	}
}