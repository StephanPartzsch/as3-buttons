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
package de.stephanpartzsch.ui.button
{
	import de.stephanpartzsch.ui.button.error.MissingLabelError;
	import de.stephanpartzsch.ui.button.event.FrameButtonEvent;
	import de.stephanpartzsch.ui.button.event.FrameLabelEvent;
	import de.stephanpartzsch.ui.button.framelabel.FrameLabelController;
	import de.stephanpartzsch.ui.button.framelabel.enum.LabelName;
	import de.stephanpartzsch.ui.shared.MovieClipDelegator;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;

	
	/**
	 * Dispatched when the enabled state of the <code>FrameButton</code> 
	 * is changed to <code>true</code>.
	 *
	 * @eventType de.stephanpartzsch.ui.button.event.FrameButtonEvent.ENABLED
	 */
	[Event(name="enabled", type="de.stephanpartzsch.ui.button.event.FrameButtonEvent")]

	/**
	 * Dispatched when the enabled state of the <code>FrameButton</code> 
	 * is changed to <code>false</code>.
	 *
	 * @eventType de.stephanpartzsch.ui.button.event.FrameButtonEvent.DISABLED
	 */	
	[Event(name="disabled", type="de.stephanpartzsch.ui.button.event.FrameButtonEvent")]
	
	/**
	 * The <code>FrameButton</code> is used to handle a button whose 
	 * visual states are represented by timeline animations.
	 * 
	 * <p>The usable states on the timeline has to be marked with FrameLabels 
	 * that have specific names as you can see below. Some of them are required,
	 * some are optional.</p>
	 * 
	 * <p>For the mouse over and mouse out states it should be considered to
	 * create animations that are appropriately equal. If the button receives a 
	 * mouse out interaction before the mouse over animation has finished, it 
	 * calculates the appropriate frame in the mouse out animation and starts
	 * playing at this frame. Therefore it can b a good approach to mirror the
	 * animations in terms of frame number as well as visualization.</p>
	 * 
	 * <p>Labels that can be used on timeline:</p>
	 * 
	 * <ul>
	 *  <li><i>default:</i>   (required) defines the 'common' state of the button</li>
	 * 	<li><i>over:</i>      (optional) called when <code>MouseEvent.ROLL_OVER</code> event is received</li>
	 * 	<li><i>out:</i>       (optional) called when <code>MouseEvent.ROLL_OUT</code> event is received</li>
	 * 	<li><i>click:</i>     (optional) called when <code>MouseEvent.MOUSE_DOWN</code> event is received</li>
	 * 	<li><i>disabled:</i>  (optional) defines the disabled state of the button</li>
	 * </ul>
	 */
	public class FrameButton extends MovieClipDelegator implements IFrameButton
	{	
		/**
		 * Defines waiting time before the next mouse click is accepted.
		 */		
		protected var CLICK_PREVENTION_TIME : Number = 500;
		
		/**
		 * The <code>FrameLabelController</code> controls the 
		 * <code>FrameLabel</code> occurences of the used MovieClip instance.
		 */	
		protected var frameLabelController : FrameLabelController;

		/**
		 * Defines whether or not prevent heavy clicking. 
		 * 
		 * <p>This is done by waiting for a specified time 
		 * (<code>CLICK_PREVENTION_TIME</code>) after each mouse click. Not until 
		 * the end of the waiting time the next mouse click is accepted.</p>
		 */		
		protected var useHeavyClickPrevention : Boolean;
		
		private var lastMouseClickTime : Number;
		
		/**
		 * Creates a new instance of type <code>FrameButton</code> with an instance 
		 * of the given buttonClass.
		 * 
		 * <p>The instance of the given buttonClass (the class should subclass 
		 * <code>MovieClip</code>) has to contain all the required labels. It will be 
		 * added to the display list of the <code>FrameButton</code> instance. Only the 
		 * <code>FrameButton</code> instance itself has to be added to a display list 
		 * to make the button visible.</p>
		 * 
		 * <p>Required labels on timeline:</p>
		 * 
		 * <ul>
		 * 	<li><i>default:</i> defines the 'common' state of the button</li> 
		 * </ul> 
		 * 
		 * <p>All MovieClip based interaction with the <code>FrameButton</code> instance 
		 * will be delegated to the instance of the given buttonClass.</p>
		 * 
		 * <p>Optionally a heavy click protection can be enabled. This is done by waiting 
		 * for a specified time (<code>CLICK_PREVENTION_TIME</code>) after each mouse click. 
		 * Not until the end of the waiting time the next mouse click is accepted.</p>
		 * 
		 * @param buttonClass An instance of this class will be used with the new <code>FrameButton</code> instance.
		 * @param useHeavyClickPrevention Whether or not prevent heavy clicking. Default is <code>false</code>.
		 *
		 * @return A new instance of type <code>FrameButton</code>.
		 * 
		 * @throws de.stephanpartzsch.ui.button.error.MissingLabelError If one or more required lab is missing
		 */
		public static function createFromClass( buttonClass : Class, useHeavyClickPrevention : Boolean = false ) : FrameButton
		{
			var buttonInstance : MovieClip = new buttonClass();
			
			return new FrameButton( buttonInstance, useHeavyClickPrevention, true );
		}

		/**
		 * Creates a new instance of type <code>FrameButton</code> with the given buttonInstance. 
		 * 
		 * <p>The buttonInstance has to contain all the required labels and will not be added 
		 * automatically to any display list. Therefore this object has to be added manually to a 
		 * display list to make the button visible.</p>
		 * 
		 * <p>Required labels on timeline:</p>
		 * 
		 * <ul>
		 * 	<li><i>default:</i> defines the 'common' state of the button</li>
		 * </ul> 
		 * 
		 * <p>All MovieClip based interaction with the <code>FrameButton</code> instance 
		 * will be delegated to the buttonInstance.</p>
		 * 
		 * <p>Optionally a heavy click protection can be enabled. This is done by waiting 
		 * for a specified time (<code>CLICK_PREVENTION_TIME</code>) after each mouse click. 
		 * Not until the end of the waiting time the next mouse click is accepted.</p>
		 * 
		 * @param buttonInstance The object that will be used with the new <code>FrameButton</code> instance.
		 * @param useHeavyClickPrevention Whether or not prevent heavy clicking. Default is <code>false</code>.
		 *
		 * @return A new instance of type <code>FrameButton</code>.
		 * 
		 * @throws de.stephanpartzsch.ui.button.error.MissingLabelError If one or more required lab is missing.
		 * @throws ArgumentError If the given buttonInstance is <code>null</code>.
		 */
		public static function createFromInstance( buttonInstance : MovieClip, useHeavyClickPrevention : Boolean = false ) : FrameButton
		{
			return new FrameButton( buttonInstance, useHeavyClickPrevention, false );
		}
		
		/**
		 * Creates a new instance of type <code>FrameButton</code> with the given buttonInstance. 
		 * 
		 * <p>The buttonInstance has to contain all the required labels and will not be added 
		 * automatically to any display list. Therefore this object has to be added manually to a 
		 * display list to make the button visible or set the optional parameter addToDisplayList
		 * to <code>true</code> to add the buttonInstance to the display list of the 
		 * <code>FrameButton</code> instance.</p>
		 * 
		 * <p>Required labels on timeline:</p>
		 * 
		 * <ul>
		 * 	<li><i>default:</i> defines the 'common' state of the button</li>
		 * </ul> 
		 * 
		 * <p>All MovieClip based interaction with the <code>FrameButton</code> instance 
		 * will be delegated to the buttonInstance.</p>
		 * 
		 * <p>Optionally a heavy click protection can be enabled. This is done by waiting 
		 * for a specified time (<code>CLICK_PREVENTION_TIME</code>) after each mouse click. 
		 * Not until the end of the waiting time the next mouse click is accepted.</p>
		 * 
		 * @param buttonInstance The object that will be used with the new <code>FrameButton</code> instance.
		 * @param useHeavyClickPrevention Whether or not prevent heavy clicking. Default is <code>false</code>.
		 * @param addToDisplayList Whether or not adding the given buttonInstance to the display list of this FrameButton. Default is <code>false</code>.
		 * 
		 * @throws de.stephanpartzsch.ui.button.error.MissingLabelError If one or more required lab is missing.
		 * @throws ArgumentError If the given buttonInstance is <code>null</code>.
		 */
		public function FrameButton( buttonInstance : MovieClip, useHeavyClickPrevention : Boolean = false, addToDisplayList : Boolean = false )
		{
			this.useHeavyClickPrevention = useHeavyClickPrevention;
			
			addMovieClip( buttonInstance, addToDisplayList );
			initialize();
		}
		
		/**
		 * Sets the enabled state of the FrameButton and shows the 
		 * appropriate visual state by jumping to the appropriate label.
		 * 
		 * @param value Whether or not the Framebutton is enabled.
		 */
		public override function set enabled( value : Boolean ) : void 
		{
			if( enabled == value )
				return;
			
			super.enabled = value;
			
			if( enabled == true )
				enableButton();
			else
				disableButton();
		}
		
		/**
		 * Does nothing because the FrameButton does not handle a selected state.
		 * Use <code>ToggleFrameButton</code> instead.
		 * 
		 * <p> This property exists because of the <code>IFrameButton</code> interface.</p>
		 * 
		 * @see de.stephanpartzsch.ui.button.IFrameButton
		 * @see de.stephanpartzsch.ui.button.ToggleFrameButton
		 */	
		public function set selected( selected : Boolean ) : void
		{
		}
		
		/**
		 * Returns always <code>false</code> because the FrameButton does not handle a selected state.
		 * Use <code>ToggleFrameButton</code> instead.
		 * 
		 * <p> This property exists because of the <code>IFrameButton</code> interface.</p>
		 * 
		 * @see de.stephanpartzsch.ui.button.IFrameButton
		 * @see de.stephanpartzsch.ui.button.ToggleFrameButton
		 */
		public function get selected() : Boolean
		{
			return false;
		}

		/**
		 * Returns the graphical representation of the FrameButton.
		 * 
		 * @return The graphical representation of the FrameButton.
		 */		
		public function get graphicalButtonInstance() : MovieClip
		{
			return movieClip;
		}

		/**
		 * Disposes the instance of type <code>FrameButton</code>.
		 * <p>It removes all event listener and disposes the used
		 * instance of <code>FrameLabelController</code>.</p>
		 */				
		public override function dispose() : void
		{
			removeMouseEventListener();
			removeFrameLabelEventListener();
			removePreventListener();
			disposeFrameLabelController();
			
			super.dispose();
		}

		/**
		 * Initializes the FrameButton.
		 * 
		 * <p>It initializes the used FrameLabelController as well as the used button 
		 * instance of type <code>MovieClip</code>, checks for required labels and
		 * add all necessary event listener.</p>
		 */
		protected function initialize() : void
		{
			initializeFrameLabelController();
			initializeMovieClip();
			
			checkFrameLabels();
			
			addMouseEventListener();
			addFrameLabelEventListener();
		}
		
		/**
		 * Checks if the MovieClip instance, which is handled by the FrameButton contains the required labels.
		 * 
		 * <p>Required labels on timeline:</p>
		 * 
		 * <ul>
		 * 	<li><i>default:</i> defines the 'common' state of the button</li> 
		 * </ul> 
		 * 
		 * @throws de.stephanpartzsch.ui.button.error.MissingLabelError If one or more required lab is missing.
		 */
		protected function checkFrameLabels() : void
		{
			switch( false )
			{
				case frameLabelController.doesLabelExistForName( LabelName.DEFAULT ):
					throw new MissingLabelError( [LabelName.DEFAULT], movieClip );
			}
		}
			
		/**
		 * Enables the button and shows the appropriate visual state.
		 */		
		protected function enableButton() : void
		{
			movieClip.buttonMode = true;			
			showEnabledState();
			removePreventListener();
			
			dispatchEvent( new FrameButtonEvent( FrameButtonEvent.ENABLED ) );
		}

		/**
		 * Disables the button and shows the appropriate visual state.
		 */
		protected function disableButton() : void
		{
			movieClip.buttonMode = false;
			showDisabledState();
			addPreventListener();

			dispatchEvent( new FrameButtonEvent( FrameButtonEvent.DISABLED ) );
		}
		
		/**
		 * Adds listeners for mouse events and optionally for the heavy click prevention.
		 * 
		 * @see flash.events.MouseEvent.ROLL_OVER
		 * @see flash.events.MouseEvent.ROLL_OUT
		 * @see flash.events.MouseEvent.MOUSE_DOWN
		 * @see flash.events.MouseEvent.MOUSE_UP
		 */
		protected function addMouseEventListener() : void
		{
			addEventListener( MouseEvent.ROLL_OVER, handleMouseRollOver );
			addEventListener( MouseEvent.ROLL_OUT, handleMouseRollOut );
			addEventListener( MouseEvent.MOUSE_DOWN, handleMouseDown );
			addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			
			if ( useHeavyClickPrevention )
				addEventListener( MouseEvent.CLICK, handleMouseClick );
		}

		/**
		 * Removes all previously added listener for mouse events.
		 */		
		protected function removeMouseEventListener() : void
		{
			removeEventListener( MouseEvent.ROLL_OVER, handleMouseRollOver );
			removeEventListener( MouseEvent.ROLL_OUT, handleMouseRollOut );
			removeEventListener( MouseEvent.MOUSE_DOWN, handleMouseDown );
			removeEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			removeEventListener( MouseEvent.CLICK, handleMouseClick );
		}

		/**
		 * Gets called when the MovieClip instance of the FrameButton receives an 
		 * MouseEvent.ROLL_OVER and moves the playhead to LabelName.OVER. If this 
		 * label could not be found, the playhead is moved to LabelName.DEFAULT.
		 * 
		 * @param event The MouseEvent that occurred.
		 */
		protected function handleMouseRollOver( event : MouseEvent ) : void
		{
			frameLabelController.gotoAndPlay( LabelName.OVER, LabelName.DEFAULT );
		}

		/**
		 * Gets called when the MovieClip instance of the FrameButton receives an 
		 * MouseEvent.ROLL_OUT and moves the playhead to LabelName.OUT. If this 
		 * label could not be found, the playhead is moved to LabelName.DEFAULT.
		 * 
		 * @param event The MouseEvent that occurred.
		 */
		protected function handleMouseRollOut( event : MouseEvent ) : void
		{
			frameLabelController.gotoAndPlay( LabelName.OUT, LabelName.DEFAULT );
		}

		/**
		 * Gets called when the MovieClip instance of the FrameButton receives an 
		 * MouseEvent.MOUSE_DOWN and moves the playhead to LabelName.CLICK. If this 
		 * label could not be found, the playhead is not moved.
		 * 
		 * @param event The MouseEvent that occurred.
		 */
		protected function handleMouseDown( event : MouseEvent ) : void
		{
			if ( frameLabelController.doesLabelExistForName( LabelName.CLICK ) )
				frameLabelController.gotoAndPlay( LabelName.CLICK );
		}

		/**
		 * Gets called when the MovieClip instance of the FrameButton receives an 
		 * MouseEvent.MOUSE_UP and moves the playhead to LabelName.OVER. If this 
		 * label could not be found, the playhead is moved to LabelName.DEFAULT.
		 * 
		 * @param event The MouseEvent that occurred.
		 */
		protected function handleMouseUp( event : MouseEvent ) : void
		{
			frameLabelController.gotoAndStop( LabelName.OVER, LabelName.DEFAULT );
		}

		/**
		 * Gets called when the heavy click prevention is enabled and the MovieClip 
		 * instance of the FrameButton receives an MouseEvent.CLICK. Then it checks 
		 * if this event should be prevented because two of them occurred to fast 
		 * in a row.
		 * 
		 * @param event The MouseEvent that occurred.
		 */
		protected function handleMouseClick( event : MouseEvent ) : void
		{
			checkToStopMouseEvent( event );
		}
		
		/**
		 * Moves the playhead of the MovieClip instance of the FrameButton to LabelName.DEFAULT.
		 */		
		protected function showEnabledState() : void
		{
			frameLabelController.gotoAndPlay( LabelName.DEFAULT );
		}
		
		/**
		 * Moves the playhead of the MovieClip instance of the FrameButton to LabelName.DEFAULT.
		 * If this label could not be found, the playhead is not moved.
		 */		
		protected function showDisabledState() : void
		{
			if( frameLabelController.doesLabelExistForName( LabelName.DISABLED ) )
				frameLabelController.gotoAndPlay( LabelName.DISABLED );
		}

		/**
		 * Gets called everytime the first frame of a label is reached. 
		 * 
		 * <p>For the FrameButton it does nothing. But it can be overriden to deal if the start
		 * of frame labels.</p>
		 * 
		 * @param event The FrameLabelEvent that occurred.
		 */		
		protected function handleFrameLabelStart( event : FrameLabelEvent ) : void
		{
		}

		/**
		 * Gets called everytime the last frame of a label is reached. 
		 * 
		 * <p>It stops the MovieClip instance of the FrameButton.</p>
		 * 
		 * @param event The FrameLabelEvent that occurred.
		 */		
		protected function handleFrameLabelEnd( event : FrameLabelEvent ) : void
		{
			movieClip.stop();
		}

		/**
		 * Stops the propagation of the given mouse event.
		 * 
		 * @param event The MouseEvent to stop.
		 */		
		protected function preventMouseEvent( event : MouseEvent ) : void
		{
			event.stopImmediatePropagation();
		}
		
		private function initializeFrameLabelController() : void
		{
			frameLabelController = new FrameLabelController( movieClip );
		}

		private function initializeMovieClip() : void
		{
			movieClip.buttonMode = true;
			movieClip.useHandCursor = true;
			
			movieClip.mouseChildren = false;
			movieClip.enabled = true;
			
			movieClip.stop();
		}
		
		private function disposeFrameLabelController() : void
		{
			frameLabelController.dispose();
			frameLabelController = null;
		}
		
		private function checkToStopMouseEvent( event : MouseEvent ) : void
		{
			var currentTime : Number = getTimer();

			if( lastMouseClickTime > 0 && currentTime < lastMouseClickTime + CLICK_PREVENTION_TIME  )
				event.stopImmediatePropagation();

			lastMouseClickTime = currentTime;
		}

		private function addFrameLabelEventListener() : void
		{
			frameLabelController.addEventListener( FrameLabelEvent.FRAME_LABEL_START, handleFrameLabelStart );
			frameLabelController.addEventListener( FrameLabelEvent.FRAME_LABEL_END, handleFrameLabelEnd );
		}

		private function removeFrameLabelEventListener() : void
		{
			frameLabelController.removeEventListener( FrameLabelEvent.FRAME_LABEL_START, handleFrameLabelStart );
			frameLabelController.removeEventListener( FrameLabelEvent.FRAME_LABEL_END, handleFrameLabelEnd );
		}
		
		private function addPreventListener() : void
		{
			addEventListener( MouseEvent.ROLL_OVER, preventMouseEvent, false, 999 );
			addEventListener( MouseEvent.ROLL_OUT, preventMouseEvent, false, 999 );
			addEventListener( MouseEvent.MOUSE_DOWN, preventMouseEvent, false, 999 );
			addEventListener( MouseEvent.MOUSE_UP, preventMouseEvent, false, 999 );
			addEventListener( MouseEvent.CLICK, preventMouseEvent, false, 999 );
		}
		
		private function removePreventListener() : void
		{
			removeEventListener( MouseEvent.ROLL_OVER, preventMouseEvent, false );
			removeEventListener( MouseEvent.ROLL_OUT, preventMouseEvent, false );
			removeEventListener( MouseEvent.MOUSE_DOWN, preventMouseEvent, false );
			removeEventListener( MouseEvent.MOUSE_UP, preventMouseEvent, false );
			removeEventListener( MouseEvent.CLICK, preventMouseEvent, false );
		}
	}
}