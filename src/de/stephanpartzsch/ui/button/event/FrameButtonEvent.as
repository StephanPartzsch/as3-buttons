package de.stephanpartzsch.ui.button.event
{
	import flash.events.Event;

	/**
	 * A FrameButtonEvent object is dispatched into the event flow whenever 
	 * a FrameButton is enabled or disabled.
	 */
	public class FrameButtonEvent extends Event
	{
		/**
		 * Defines the value of the type property of an enabled event object. 
		 * It is fired if the FrameButton gets enabled.
		 */
		public static const ENABLED : String = "enabled";

		/**
		 * Defines the value of the type property of an disabled event object. 
		 * It is fired if the FrameButton gets enabled.
		 */		
		public static const DISABLED : String = "disabled";
		
		/**
		 * Creates a FrameButtonEvent object to pass as a parameter to event listeners.
		 * 
		 * @param type The type of the event, accessible as <code>FrameButtonEvent.type</code>.
		 * @param bubbles Determines whether the FrameButtonEvent object participates in the bubbling stage of the event flow. The default value is <code>false</code>.
		 * @param cancelable Determines whether the FrameButtonEvent object can be canceled. The default values is <code>false</code>.
		 */
		public function FrameButtonEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}