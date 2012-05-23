package de.stephanpartzsch.ui.button.example
{
	import de.stephanpartzsch.ui.button.FrameButton;
	import de.stephanpartzsch.ui.button.LabeledFrameButton;
	import de.stephanpartzsch.ui.button.ToggleFrameButton;
	import de.stephanpartzsch.ui.button.graphic.ExampleButton;
	import de.stephanpartzsch.ui.button.graphic.ExampleLabelButton;
	import de.stephanpartzsch.ui.button.graphic.ExampleToggleButton;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class FrameButtonExampleSwc extends Sprite
	{
		private var actionButton : Sprite;
		
		private var frameButton : FrameButton;
		private var labeledFrameButton : LabeledFrameButton;
		private var toggleFrameButton : ToggleFrameButton;
		
		public function FrameButtonExampleSwc()
		{
			buildActionButton();
			buildFrameButton();
			buildLabeledFrameButton();
			buildToggleFrameButton();
		}

		private function buildActionButton() : void
		{
			actionButton = new Sprite();
			actionButton.graphics.beginFill( 0x2299ff, 1 );
			actionButton.graphics.drawRect( 10, 3, 100, 20 );
			actionButton.graphics.endFill();

			var textField : TextField = new TextField();
			textField.selectable = false;
			textField.autoSize = TextFieldAutoSize.CENTER;
			textField.text = "Enable/Disable";
			textField.textColor = 0xffffff;
			textField.x = 20;
			textField.y = 6;
			
			actionButton.addChild( textField );
			actionButton.mouseChildren = false;
			actionButton.buttonMode = true;
			actionButton.addEventListener( MouseEvent.CLICK, toggleEnableButtons );

			addChild( actionButton );
		}

		private function toggleEnableButtons( event : MouseEvent ) : void
		{
			frameButton.enabled = !frameButton.enabled;
			labeledFrameButton.enabled = !labeledFrameButton.enabled;
			toggleFrameButton.enabled = !toggleFrameButton.enabled;
		}

		private function buildFrameButton() : void
		{
			frameButton = FrameButton.createFromClass( ExampleButton );
			frameButton.x = 200;
			frameButton.y = 100;
			frameButton.addEventListener( MouseEvent.CLICK, handleFrameButtonClicked );

			addChild( frameButton );
		}

		private function handleFrameButtonClicked(event : MouseEvent) : void 
		{
			disposeActionButton();
			disposeFrameButton();
		}

		private function disposeActionButton() : void
		{
			actionButton.removeEventListener( MouseEvent.CLICK, toggleEnableButtons );
			removeChild( actionButton );
			actionButton = null;
		}

		private function disposeFrameButton() : void
		{
			removeChild( frameButton );
			frameButton.removeEventListener( MouseEvent.CLICK, disposeFrameButton );
			
			frameButton.dispose();
			frameButton = null;
		}
		
		private function buildLabeledFrameButton() : void
		{
			labeledFrameButton = LabeledFrameButton.createFromClass( ExampleLabelButton, "Test" );
			labeledFrameButton.x = 200;
			labeledFrameButton.y = 150;
	
			addChild( labeledFrameButton );
		}
		
		private function buildToggleFrameButton() : void
		{
			toggleFrameButton = ToggleFrameButton.createFromClass( ExampleToggleButton, true );
			toggleFrameButton.x = 200;
			toggleFrameButton.y = 200;
			
			addChild( toggleFrameButton );
		}
	}
}