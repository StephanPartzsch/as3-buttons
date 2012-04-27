package de.stephanpartzsch.ui.button
{
	import flash.display.MovieClip;
	
	/**
	 * The IFrameButton interface defines methods for the enabling, disabling, 
	 * selecting, deselecting and disposing a FrameButton as well as for returning 
	 * the MovieClip instance which is used within a FrameButton.
	 */
	public interface IFrameButton
	{
		/**
		 * Sets the enabled state of the FrameButton and shows the 
		 * appropriate visual state by jumping to the appropriate label.
		 * 
		 * @param value Whether or not the Framebutton is enabled.
		 */
		function set enabled( value : Boolean ) : void;
		
		/**
		 * Returns whether or not the FrameButton is enabled.
		 * 
		 * @return Whether or not the Framebutton is enabled.
		 */		
		function get enabled() : Boolean;
		
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
		function set selected( selected : Boolean ) : void;
		
		/**
		 * Returns the selected state of the ToggleFrameButton.
		 * 
		 * <p>This property reflects no functionality and bears no meaning 
		 * for a simple FrameButton instance. It should only be used for
		 * a ToggleFrameButton instance.</p>
		 * 
		 * @return value Whether or not the ToggleFrameButton is selected.
		 */
		function get selected() : Boolean;

		/**
		 * Returns the graphical representation of the FrameButton.
		 * 
		 * @return The graphical representation of the FrameButton.
		 */				
		function get graphicalButtonInstance() : MovieClip;

		/**
		 * Disposes the FrameButton.
		 * <p>It cleans up everything and makes the FrameButton ready for 
		 * Garbage Collection.</p>
		 */		
		function dispose() : void;
	}
}