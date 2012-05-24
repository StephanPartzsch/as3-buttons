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
	import de.stephanpartzsch.ui.button.labeltext.LabelTextController;
	import flash.display.MovieClip;

	/**
	 * The <code>LabeledToggleFrameButton</code> is used to handle a button whose 
	 * visual states are represented by timeline animations. In addition to the 
	 * functionality of the <code>ToggleFrameButton</code> it controlls a label 
	 * text field.
	 * 
	 * <p>The TextField has to have the name <b>labelText</b>. It is possible to place 
	 * this TextField directly on the timeline or wrap it in an other MovieClip named 
	 * <b>textContainer</b>.</p>
	 * <p>Moreover the label text can be centered vertically, if the text field is bigger
	 * than required</p>
	 * 
	 * @see de.stephanpartzsch.ui.button.ToggleFrameButton
	 */
	public class LabeledToggleFrameButton extends ToggleFrameButton
	{
		private var labelDecorator : LabelTextController;

		/**
		 * Creates a new instance of type <code>LabeledToggleFrameButton</code> with an instance 
		 * of the given buttonClass.
		 * 
		 * <p>The instance of the given buttonClass (the class should subclass 
		 * <code>MovieClip</code>) has to contain all the required labels. It will be 
		 * added to the display list of the <code>LabeledToggleFrameButton</code> instance. Only the 
		 * <code>LabeledToggleFrameButton</code> instance itself has to be added to a display list 
		 * to make the button visible.</p>
		 * 
		 * <p>Required labels on timeline:</p>
		 * 
		 * <ul>
		 * 	<li><i>default:</i> defines the 'common' state of the button</li> 
		 * </ul> 
		 * 
		 * <p>All MovieClip based interaction with the <code>LabeledToggleFrameButton</code> instance 
		 * will be delegated to the instance of the given buttonClass.</p>
		 * 
		 * <p>Optionally a heavy click protection can be enabled. This is done by waiting 
		 * for a specified time (<code>CLICK_PREVENTION_TIME</code>) after each mouse click. 
		 * Not until the end of the waiting time the next mouse click is accepted.</p>
		 * 
		 * <p>The TextField has to have the name <b>labelText</b>. It is possible to place 
		 * this TextField directly on the timeline or wrap it in an other MovieClip named 
		 * <b>textContainer</b>.</p>
		 * 
		 * @param buttonClass An instance of this class will be used with the new <code>LabeledToggleFrameButton</code> instance.
		 * @param label The label text that is to be used in the text field of <code>buttonInstance</code>.
		 * @param centerTextVertically Whether or not the label text is to be centered vertically. Default is <code>false</code>.
		 * @param useHeavyClickPrevention Whether or not prevent heavy clicking. Default is <code>false</code>.
		 *
		 * @return A new instance of type <code>LabeledToggleFrameButton</code>.
		 * 
		 * @throws de.stephanpartzsch.ui.button.error.MissingLabelError If one or more required lab is missing
		 * @throws ReferenceError If no text field can be found in the given MovieClip instance.
		 */
		public static function createFromClass( buttonClass : Class, label : String = "", centerTextVertically : Boolean = false, useHeavyClickPrevention : Boolean = false ) : LabeledToggleFrameButton
		{
			var buttonInstance : MovieClip = new buttonClass();
			
			return new LabeledToggleFrameButton( buttonInstance, label, centerTextVertically, useHeavyClickPrevention, true );
		}
		
		/**
		 * Creates a new instance of type <code>LabeledToggleFrameButton</code> with the given buttonInstance. 
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
		 * <p>All MovieClip based interaction with the <code>LabeledToggleFrameButton</code> instance 
		 * will be delegated to the buttonInstance.</p>
		 * 
		 * <p>Optionally a heavy click protection can be enabled. This is done by waiting 
		 * for a specified time (<code>CLICK_PREVENTION_TIME</code>) after each mouse click. 
		 * Not until the end of the waiting time the next mouse click is accepted.</p>
		 * 
		 * <p>The TextField has to have the name <b>labelText</b>. It is possible to place 
		 * this TextField directly on the timeline or wrap it in an other MovieClip named 
		 * <b>textContainer</b>.</p>
		 * 
		 * @param buttonInstance The object that will be used with the new <code>LabeledToggleFrameButton</code> instance.
		 * @param label The label text that is to be used in the text field of <code>buttonInstance</code>.
		 * @param centerTextVertically Whether or not the label text is to be centered vertically. Default is <code>false</code>.
		 * @param useHeavyClickPrevention Whether or not prevent heavy clicking. Default is <code>false</code>.
		 *
		 * @return A new instance of type <code>LabeledToggleFrameButton</code>.
		 * 
		 * @throws de.stephanpartzsch.ui.button.error.MissingLabelError If one or more required lab is missing.
		 * @throws ArgumentError If the given buttonInstance is <code>null</code>.
		 * @throws ReferenceError If no text field can be found in the given MovieClip instance.
		 */
		public static function createFromInstance( buttonInstance : MovieClip, label : String = "", centerTextVertically : Boolean = false, useHeavyClickPrevention : Boolean = false ) : LabeledToggleFrameButton
		{
			return new LabeledToggleFrameButton( buttonInstance, label, centerTextVertically, useHeavyClickPrevention, false );
		}
		
		/**
		 * Creates a new instance of type <code>LabeledToggleFrameButton</code> with the given buttonInstance.
		 * 
		 * @param buttonInstance The object that will be used with the new <code>LabeledToggleFrameButton</code> instance.
		 * @param label The label text that is to be used in the text field of <code>buttonInstance</code>.
		 * @param centerTextVertically Whether or not the label text is to be centered vertically. Default is <code>false</code>.
		 * @param heavyClickProtectionEnabled Whether or not prevent heavy clicking. Default is <code>false</code>.
		 * @param addToDisplayList Whether or not adding the given buttonInstance to the display list of this LabeledFrameButton. Default is <code>false</code>.
		 * 
		 * @throws de.stephanpartzsch.ui.button.error.MissingLabelError If one or more required lab is missing
		 * @throws ReferenceError If no text field can be found in the given MovieClip instance.
		 */
		public function LabeledToggleFrameButton( buttonInstance : MovieClip, label : String = "", centerTextVertically : Boolean = false, heavyClickProtectionEnabled : Boolean = false, addToDisplayList : Boolean = false )
		{
			super( buttonInstance, heavyClickProtectionEnabled, addToDisplayList );
			labelDecorator = new LabelTextController( buttonInstance, label, centerTextVertically );
		}
		
		/**
		 * Disposes the LabeledToggleFrameButton.
		 * <p>It cleans up everything and makes the LabeledToggleFrameButton ready for 
		 * Garbage Collection.</p>
		 */
		public override function dispose() : void
		{
			super.dispose();
			labelDecorator.dispose();
			labelDecorator = null;
		}
	}
}