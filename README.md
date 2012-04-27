#AS3 Buttons#

   

This library provides an easy way to handle timeline based graphics as buttons in ActionScript 3. 
Some frame labels are required, but beside this, the button can be very simple with only one graphical state. The library extends this graphical representation with the usual button behavior (buttonMode, enable/disable) and an optional heavy click protection.

But the classical meaning of this library is represented by the `FrameButton`. It controls the graphical states of the button for `MOUSE.ROLL_OVER`, `MOUSE.ROLL_OUT`, `MOUSE.MOUSE_DOWN` and `MOUSE.MOUSE_UP` events as well as for a disabled state. If the graphical states for `MOUSE.ROLL_OVER` and `MOUSE.ROLL_OUT` events contain animations the library calculates the appropriate frame of the next label. This is done by taking the position of the playhead in the current label into consideration.
Furthermore the library contains a `ToggleFrameButton` which handles a selection state in addition to the `FrameButton`. This class manages the graphical states for mouse events and the disabled state if the button is selected `true` or `false`.

The most important classes are:

- FrameButton
- ToggleFrameButton


---   
   
###Usage###


####Graphical button representation####
The timeline based button graphics have to contain some required labels. A `FrameButton` representation has to contain "default" as a label on the timeline. And for a `ToggleFrameButton` it has to be "default" as well as "selected_default". 
   
Typical timeline representation of a `FrameButton`:   
![Typical timeline representation of a FrameButton](https://github.com/StephanPartzsch/as3-buttons/blob/develop/example/asset_example/graphic/typical_frame_button.png?raw=true  "Typical timeline representation of a FrameButton")
   
Simple timeline representation of a `FrameButton`:  
![Simple timeline representation of a FrameButton](https://github.com/StephanPartzsch/as3-buttons/blob/develop/example/asset_example/graphic/simple_frame_button.png?raw=true  "Simple timeline representation of a FrameButton")
   
Typical timeline representation of a `ToggleFrameButton`:  
![Typical timeline representation of a ToggleFrameButton](https://github.com/StephanPartzsch/as3-buttons/blob/develop/example/asset_example/graphic/typical_toggle_frame_button.png?raw=true  "Typical timeline representation of a ToggleFrameButton")
   
Simple timeline representation of a `ToggleFrameButton`:  
![Simple timeline representation of a ToggleFrameButton](https://github.com/StephanPartzsch/as3-buttons/blob/develop/example/asset_example/graphic/simple_toggle_frame_button.png?raw=true  "Simple timeline representation of a ToggleFrameButton")
   


####Basic usage####

*FrameButton*

			var frameButton : FrameButton = FrameButton.createFromClass( ExampleButton );
			addChild( frameButton );
   
*ToggleFrameButton*

			var toggleFrameButton : ToggleFrameButton = ToggleFrameButton.createFromClass( ExampleToggleButton );
			addChild( toggleFrameButton );

   
The `FrameButton` as well as the `ToggleFrameButton` can be used like normal MovieClips because nearly everything is delegated to the graphical button representation which is managed by `FrameButton` or `ToggleFrameButton`.

			frameButton.x = 100;
			frameButton.rotationX = 20;
			frameButton.addEventListener( MouseEvent.CLICK, handleFrameButtonClicked );