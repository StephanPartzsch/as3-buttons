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
	import de.stephanpartzsch.ui.button.framelabel.enum.LabelName;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	
	/**
	 * The <code>ToggleFrameButton</code> is used to handle a button whose 
	 * visual states are represented by timeline animations. 
	 * 
	 * <p>It behaves the same as the <code>FrameButton</code> but the button
	 * is also be able to be toggled. Therefore some additional frame labels
	 * are used.</p>
	 * 
	 * <p>Labels that can be used on timeline:</p>
	 * 
	 * <ul>
	 * 	<li><i>default:</i>   (required) defines the 'common' state of the button</li>
	 * 	<li><i>over:</i>      (optional) called when <code>MouseEvent.ROLL_OVER</code> event is received</li>
	 * 	<li><i>out:</i>       (optional) called when <code>MouseEvent.ROLL_OUT</code> event is received</li>
	 * 	<li><i>click:</i>     (optional) called when <code>MouseEvent.MOUSE_DOWN</code> event is received</li>
	 * 	<li><i>disabled:</i>  (optional) defines the disabled state of the button</li>
	 * 	<li><i>selected_default:</i>   (required) defines the 'common' state of the button if selected</li>
	 * 	<li><i>selected_over:</i>      (optional) called when <code>MouseEvent.ROLL_OVER</code> event is received and the button is selected</li>
	 * 	<li><i>selected_out:</i>       (optional) called when <code>MouseEvent.ROLL_OUT</code> event is received and the button is selected</li>
	 * 	<li><i>selected_click:</i>     (optional) called when <code>MouseEvent.MOUSE_DOWN</code> event is received and the button is selected</li>
	 * 	<li><i>selected_disabled:</i>  (optional) defines the disabled state of the button if selected</li>
	 * </ul>
	 * 
	 * @see de.stephanpartzsch.ui.button.FrameButton
	 */
	public class ToggleFrameButton extends FrameButton implements IFrameButton
	{
		private var _selected : Boolean;
		
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
		public static function createFromClass( ButtonClass : Class, useHeavyClickPrevention : Boolean = false ) : ToggleFrameButton
		{
			var buttonInstance : MovieClip = new ButtonClass();
			
			return new ToggleFrameButton( buttonInstance, useHeavyClickPrevention, true );
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
		public static function createFromInstance( buttonInstance : MovieClip, useHeavyClickPrevention : Boolean = false ) : ToggleFrameButton
		{
			return new ToggleFrameButton( buttonInstance, useHeavyClickPrevention, false );
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
		public function ToggleFrameButton( buttonInstance : MovieClip, useHeavyClickPrevention : Boolean = false, addToDisplayList : Boolean = false )
		{
			super( buttonInstance, useHeavyClickPrevention, addToDisplayList );
			
			_selected = false;
			showSelectedState();
		}
		
		/**
		 * Sets the selected state of the ToggleFrameButton and shows the 
		 * appropriate visual state by jumping to the appropriate label.
		 * 
		 * @param value Whether or not the ToggleFrameButton is selected.
		 */
		public override function set selected( selected : Boolean ) : void
		{
			if ( _selected == selected )
				return;
			
			_selected = selected;		
			showSelectedState();
		}
		
		/**
		 * Returns the selected state of the ToggleFrameButton.
		 * 
		 * @return value Whether or not the ToggleFrameButton is selected.
		 */
		public override function get selected() : Boolean
		{
			return _selected;
		}
		
		/**
		 * Shows the visual state for the current 'selected state' of ToggleFrameButton.
		 * 
		 * <p>If the button has not been selected before, the playhead is moved to <code>LabelName.SELECTED_OVER</code> 
		 * if the mouse is over the button ( and if <code>LabelName.SELECTED_OVER</code> exists), otherwise to 
		 * <code>LabelName.SELECTED_DEFAULT</code>.</p>
		 * 
		 * <p>If the button has been selected before, the playhead is moved to <code>LabelName.OVER</code> 
		 * if the mouse is over the button ( and if <code>LabelName.OVER</code> exists), otherwise to 
		 * <code>LabelName.DEFAULT</code>.</p>
		 */		
		protected function showSelectedState() : void
		{
			if ( selected == true )
			{
				if ( movieClip.currentLabel == LabelName.OVER || movieClip.currentLabel == LabelName.CLICK )
					frameLabelController.gotoAndStop( LabelName.SELECTED_OVER, LabelName.SELECTED_DEFAULT );
				else
					frameLabelController.gotoAndStop( LabelName.SELECTED_DEFAULT );
			}
			else
			{
				if ( movieClip.currentLabel == LabelName.SELECTED_OVER || movieClip.currentLabel == LabelName.SELECTED_CLICK )
					frameLabelController.gotoAndStop( LabelName.OVER, LabelName.DEFAULT );
				else
					frameLabelController.gotoAndStop( LabelName.DEFAULT );
			}
		}
				
		/**
		 * Checks if the MovieClip instance, which is handled by the ToggleFrameButton contains the required labels.
		 * 
		 * <p>Required labels on timeline:</p>
		 * 
		 * <ul>
		 * 	<li><i>default:</i> defines the 'common' state of the button</li>
		 * 	<li><i>selected_default:</i> defines the 'common' state of the button if selected</li>
		 * </ul> 
		 * 
		 * @throws de.stephanpartzsch.ui.button.error.MissingLabelError If one or more required lab is missing.
		 */
		protected override function checkFrameLabels() : void
		{
			super.checkFrameLabels();
			
			switch( false )
			{
				case frameLabelController.doesLabelExistForName( LabelName.SELECTED_DEFAULT ):
					throw new MissingLabelError( [LabelName.SELECTED_DEFAULT], movieClip );
			}
		}

		/**
		 * Gets called when the MovieClip instance of the ToggleFrameButton receives an 
		 * MouseEvent.ROLL_OVER. If the selected state is <code>true</code> it moves the 
		 * playhead to LabelName.SELECTED_OVER or to LabelName.SELECTED_DEFAULT, if 
		 * LabelName.SELECTED_OVER could not be found. Otherwise <code>handleMouseRollOver</code>
		 * of the FrameButton super class is called.
		 * 
		 * @param event The MouseEvent that occurred.
		 */
		protected override function handleMouseRollOver( event : MouseEvent ) : void
		{
			if ( selected == true  )
				frameLabelController.gotoAndPlay( LabelName.SELECTED_OVER, LabelName.SELECTED_DEFAULT );
			else
				super.handleMouseRollOver( event );
		}

		/**
		 * Gets called when the MovieClip instance of the ToggleFrameButton receives an 
		 * MouseEvent.ROLL_OVER. If the selected state is <code>true</code> it moves the 
		 * playhead to LabelName.SELECTED_OUT or to LabelName.SELECTED_DEFAULT, if 
		 * LabelName.SELECTED_OUT could not be found. Otherwise <code>handleMouseRollOut</code>
		 * of the FrameButton super class is called.
		 * 
		 * @param event The MouseEvent that occurred.
		 */	
		protected override function handleMouseRollOut( event : MouseEvent ) : void
		{
			if ( selected )
				frameLabelController.gotoAndPlay( LabelName.SELECTED_OUT, LabelName.SELECTED_DEFAULT );
			else
				super.handleMouseRollOut( event );
		}

		/**
		 * Gets called when the MovieClip instance of the ToggleFrameButton receives an 
		 * MouseEvent.MOUSE_DOWN and moves the playhead to LabelName.SELECTED_CLICK, if 
		 * it could be found. Otherwise <code>handleMouseDown</code>
		 * of the FrameButton super class is called.
		 * 
		 * @param event The MouseEvent that occurred.
		 */
		protected override function handleMouseDown( event : MouseEvent ) : void
		{
			if ( selected == true  )
			{
				if ( frameLabelController.doesLabelExistForName( LabelName.SELECTED_CLICK ) )
					frameLabelController.gotoAndPlay( LabelName.SELECTED_CLICK );
			}
			else
			{
				super.handleMouseDown( event );
			}
		}

		/**
		 * Gets called when the MovieClip instance of the ToggleFrameButton receives an 
		 * MouseEvent.ROLL_OVER. If the selected state is <code>true</code> it moves the 
		 * playhead to LabelName.SELECTED_OVER or to LabelName.SELECTED_DEFAULT, if 
		 * LabelName.SELECTED_OVER could not be found. Otherwise <code>handleMouseUp</code>
		 * of the FrameButton super class is called.
		 * 
		 * @param event The MouseEvent that occurred.
		 */	
		protected override function handleMouseUp( event : MouseEvent ) : void
		{
			selected = !selected;
		}

		/**
		 * Moves the playhead of the MovieClip instance of the ToggleFrameButton to 
		 * LabelName.SELECTED_DEFAULT, if the selected state is <code>true</code>. Otherwise 
		 * <code>showEnabledState</code> of the FrameButton super class is called. 
		 */	
		protected override function showEnabledState() : void
		{
			if ( selected == true )
				frameLabelController.gotoAndPlay( LabelName.SELECTED_DEFAULT );
			else
				super.showEnabledState();
		}

		/**
		 * Moves the playhead of the MovieClip instance of the ToggleFrameButton to 
		 * LabelName.SELECTED_DISABLED, if the selected state is <code>true</code>. Otherwise 
		 * <code>showDisabledState</code> of the FrameButton super class is called. 
		 */	
		protected override function showDisabledState() : void
		{
			if ( selected == true  )
			{
				if( frameLabelController.doesLabelExistForName( LabelName.SELECTED_DISABLED ) )
					frameLabelController.gotoAndPlay( LabelName.SELECTED_DISABLED );
			}
			else
			{
				super.showDisabledState();	
			}
		}
	}	
}