package de.stephanpartzsch.ui.button
{
	import de.stephanpartzsch.ui.button.event.FrameButtonEvent;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class LabeledFrameButton extends MovieClip implements IFrameButton
	{
		protected var label : String;
		
		private var frameButton : IFrameButton;
		private var movieClip : MovieClip;



// Delegiert nur die wichtigsten dinge
// add + has + sremove eventlistener mit aufnehmen




		public function LabeledFrameButton( frameButton : IFrameButton, label : String = "" )
		{
			this.frameButton = frameButton;
			this.label = label;
			this.movieClip = frameButton.graphicalButtonInstance;
						
			checkForTextField();
			
			addChild( frameButton as DisplayObject );
			configureTextLabelUpdating();
			updateTextLabel();
		}

		/**
		 * Disposes the FrameButton.
		 * <p>It cleans up everything and makes the FrameButton ready for 
		 * Garbage Collection.</p>
		 */
		public function dispose() : void
		{
			removeEventListenerForButton( frameButton as DisplayObject );
			
			frameButton.dispose();
			frameButton = null;
			
			movieClip = null;
		}
		
		/**
		 * Sets the enabled state of the FrameButton and shows the 
		 * appropriate visual state by jumping to the appropriate label.
		 * 
		 * @param value Whether or not the Framebutton is enabled.
		 */		
		public override function set enabled( value : Boolean ) : void
		{
			frameButton.enabled = value;
		}
		
		/**
		 * Returns whether or not the FrameButton is enabled.
		 * 
		 * @return Whether or not the Framebutton is enabled.
		 */			
		public override function get enabled() : Boolean
		{
			return frameButton.enabled;
		}

		/**
		 * Sets the selected state of the ToggleFrameButton and shows the 
		 * appropriate visual state by jumping to the appropriate label.
		 * 
		 * <p>This property reflects no functionality and bears no meaning 
		 * for a simple FrameButton instance. It should only be used for
		 * a ToggleFrameButton instance.</p>
		 * 
		 * @param value Whether or not the ToggleFrameButton is selected.
		 */			
		public function set selected( selected : Boolean ) : void
		{
			frameButton.selected = selected;
		}

		/**
		 * Returns the selected state of the ToggleFrameButton.
		 * 
		 * <p>This property reflects no functionality and bears no meaning 
		 * for a simple FrameButton instance. It should only be used for
		 * a ToggleFrameButton instance.</p>
		 * 
		 * @return value Whether or not the ToggleFrameButton is selected.
		 */
		public function get selected() : Boolean
		{
			return frameButton.selected;
		}
		
		/**
		 * Returns the graphical representation of the FrameButton.
		 * 
		 * @return The graphical representation of the FrameButton.
		 */	
		public function get graphicalButtonInstance() : MovieClip
		{
			return frameButton.graphicalButtonInstance;
		}
		
		/**
		 * Adds event listener for events of type MouseEvent and FrameButtonEvent 
		 * (which are dispatched by the FrameButton) to update the Textfield if 
		 * a new frame label is reached.
		 */
		protected function configureTextLabelUpdating() : void
		{
			addEventListenerForButton( frameButton as DisplayObject );
		}
		
		/**
		 * Updates the <code>hmtlText</code> of the TextField in the MovieClip 
		 * instance of the given IFrameButton.
		 */
		protected function updateTextLabel( event : Event = null ) : void
		{
			labelTextField.htmlText = label;
		}
		
		/**
		 * Returns whether or not a TextField in the MovieClip instance of the given 
		 * IFrameButton could be found and a non empty Text is available.
		 * 
		 * @return Whether or not a TextField in the MovieClip instance of the given IFrameButton could be found and a non empty Text is available.
		 */	
		protected function get hasLabel() : Boolean
		{
			return label != "" && labelTextField != null;
		}
		
		/**
		 * Returns the TextField in the MovieClip instance of the given IFrameButton.
		 * 
		 *  <p>The TextField has to have the name <b>labelText</b>. 
		 *  It is possible to place this TextField directly on the timeline or wrap it 
		 *  in an other MovieClip named <b>textContainer</b>.</p>		 
		 */
		protected function get labelTextField() : TextField
		{
			if ( movieClip["labelText"] as TextField != null )
				return movieClip["labelText"] as TextField;
			else 
			if ( movieClip["textContainer"] && movieClip["textContainer"]["labelText"] )
				return movieClip["textContainer"]["labelText"] as TextField;

			return null;
		}

		private function checkForTextField() : void
		{
			if( !hasLabel )
				throw new IllegalOperationError( "The MovieClip instance 8used in FrameButton instance) has to contain a TextField named 'labelText' (directly on timeline or wrapped in a MovieClip named 'textContainer' on timeline!" );
		}
			
		private function removeEventListenerForButton( button : DisplayObject ) : void
		{
			button.removeEventListener( MouseEvent.ROLL_OVER, updateTextLabel );
			button.removeEventListener( MouseEvent.ROLL_OUT, updateTextLabel );
			button.removeEventListener( MouseEvent.MOUSE_DOWN, updateTextLabel );
			button.removeEventListener( MouseEvent.MOUSE_UP, updateTextLabel );
			button.removeEventListener( FrameButtonEvent.DISABLED, updateTextLabel );
			button.removeEventListener( FrameButtonEvent.ENABLED, updateTextLabel );
		}
		
		private function addEventListenerForButton( button : DisplayObject ) : void
		{
			button.addEventListener( MouseEvent.ROLL_OVER, updateTextLabel );
			button.addEventListener( MouseEvent.ROLL_OUT, updateTextLabel );
			button.addEventListener( MouseEvent.MOUSE_DOWN, updateTextLabel );
			button.addEventListener( MouseEvent.MOUSE_UP, updateTextLabel );
			button.addEventListener( FrameButtonEvent.DISABLED, updateTextLabel );
			button.addEventListener( FrameButtonEvent.ENABLED, updateTextLabel );
		}
	}
}