package de.stephanpartzsch.ui.button.event
{
	import flash.events.Event;

	/**
	 * A FrameLabelEvent object is dispatched into the event flow whenever 
	 * frame label events occur. A frame label event is generated when the start 
	 * or the end of a label of a MovieClip inside any instance of type 
	 * <code>FrameButton</code> is reached.
	 */
	public class FrameLabelEvent extends Event
	{
		/**
		 * Defines the value of the type property of a frame label start event object. 
		 * It is fired if the first frame of a label is reached.
		 * 
		 * <p>This event contains the name of the current label as 
		 * <code>currentFrameLabelName</code>.</p>
		 */
		public static const FRAME_LABEL_START : String = "frame_label_start";
		
		/**
		 * Defines the value of the type property of a frame label end event object. 
		 * It is fired if the last frame of a label is reached.
		 * 
		 * <p>This event contains the name of the current label as 
		 * <code>currentFrameLabelName</code>.</p>
		 */
		public static const FRAME_LABEL_END : String = "frame_label_end";
		
		private var _currentFrameLabelName : String;
		
		/**
		 * Creates a FrameLabelEvent object to pass as a parameter to event listeners.
		 * 
		 * @param type The type of the event, accessible as <code>FrameLabelEvent.type</code>.
		 * @param currentFrameLabelName The name of the current label in which the first frame (start) or the last frame (end) was detected.
		 * @param bubbles Determines whether the FrameLabelEvent object participates in the bubbling stage of the event flow. The default value is <code>false</code>.
		 * @param cancelable Determines whether the FrameLabelEvent object can be canceled. The default values is <code>false</code>.
		 */
		public function FrameLabelEvent( type : String, currentFrameLabelName : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			_currentFrameLabelName = currentFrameLabelName;
			super( type, bubbles, cancelable );
		}

		/**
		 * The name of the current label in which the first frame (start) 
		 * or the last frame (end) was detected.
		 */
		public function get currentFrameLabelName() : String
		{
			return _currentFrameLabelName;
		}
		
		/**
		 * Creates a copy of the MouseEvent object and sets the value of each property to
		 * match that of the original.
		 * 
		 * @return A new MouseEvent object with property values that match those of the original.
		 */
		public override function clone() : Event
		{
			return new FrameLabelEvent( type, currentFrameLabelName, bubbles, cancelable );
		}
	}
}