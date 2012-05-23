package de.stephanpartzsch.ui.button.example
{
	import de.stephanpartzsch.ui.button.FrameButton;
	import de.stephanpartzsch.ui.button.LabeledFrameButton;
	import de.stephanpartzsch.ui.button.ToggleFrameButton;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;

	public class FrameButtonExampleSwf extends Sprite
	{
		private var actionButton : Sprite;
		private var frameButton : FrameButton;
		private var labeledFrameButton : LabeledFrameButton;
		private var toggleFrameButton : ToggleFrameButton;
		
		public function FrameButtonExampleSwf()
		{
			loadGraphics();
		}

		private function loadGraphics() : void
		{
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, handleGraphicsLoaded );
			loader.load( new URLRequest( "graphic/button_graphics.swf" ), new LoaderContext( false, ApplicationDomain.currentDomain ) );
		}

		private function handleGraphicsLoaded( event : Event ) : void
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
			var buttonClass : Class = getDefinitionByName( "de.stephanpartzsch.ui.button.graphic.ExampleButton" ) as Class;
			frameButton = FrameButton.createFromClass( buttonClass );
			frameButton.x = 200;
			frameButton.y = 100;
	
			addChild( frameButton );
		}
		
		private function buildLabeledFrameButton() : void
		{
			var buttonClass : Class = getDefinitionByName( "de.stephanpartzsch.ui.button.graphic.ExampleLabelButton" ) as Class;
			labeledFrameButton = LabeledFrameButton.createFromClass( buttonClass, "Test" );
			labeledFrameButton.x = 200;
			labeledFrameButton.y = 150;
	
			addChild( labeledFrameButton );
		}
		
		private function buildToggleFrameButton() : void
		{
			var buttonClass : Class = getDefinitionByName( "de.stephanpartzsch.ui.button.graphic.ExampleToggleButton" ) as Class;
			toggleFrameButton = ToggleFrameButton.createFromClass( buttonClass, true );
			toggleFrameButton.x = 200;
			toggleFrameButton.y = 200;
			toggleFrameButton.addEventListener( MouseEvent.CLICK, handleToggleFrameButtonClicked );
	
			addChild( toggleFrameButton );
		}

		private function handleToggleFrameButtonClicked( event : MouseEvent ) : void
		{
			toggleFrameButton.selected = !toggleFrameButton.selected;
		}
	}
}