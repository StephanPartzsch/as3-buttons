package de.stephanpartzsch.ui.button.labeltext
{
	import de.stephanpartzsch.ui.button.event.FrameButtonEvent;
	import de.stephanpartzsch.ui.button.graphic.ExampleLabelButton;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class LabelTextControllerTest
	{
		[Test]
		public function test_constructor() : void
		{
			var buttonGraphic : MovieClip = new ExampleLabelButton();
			var labelTextDecorator : LabelTextController = new LabelTextController( buttonGraphic, "text" );
			
			assertEquals( "unexpected value for singleLineOffsetY", 7, labelTextDecorator.singleLineOffsetY );
			assertEquals( "unexpected text for label text field", "text", TextField( buttonGraphic["labelText"] ).text );
			
			assertTrue( buttonGraphic.hasEventListener( MouseEvent.ROLL_OVER ) );
			assertTrue( buttonGraphic.hasEventListener( MouseEvent.ROLL_OUT ) );
			assertTrue( buttonGraphic.hasEventListener( MouseEvent.MOUSE_DOWN ) );
			assertTrue( buttonGraphic.hasEventListener( MouseEvent.MOUSE_UP ) );
			assertTrue( buttonGraphic.hasEventListener( FrameButtonEvent.DISABLED ) );
			assertTrue( buttonGraphic.hasEventListener( FrameButtonEvent.ENABLED ) );
		}
		
		[Test]
		public function test_constructor_with_no_label_text() : void
		{
			var buttonGraphic : MovieClip = new ExampleLabelButton();
			var labelTextDecorator : LabelTextController = new LabelTextController( buttonGraphic, "" );
			
			assertEquals( "unexpected value for singleLineOffsetY", 7, labelTextDecorator.singleLineOffsetY );
			assertEquals( "unexpected text for label text field", "---", TextField( buttonGraphic["labelText"] ).text );
			
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.ROLL_OVER ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.ROLL_OUT ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.MOUSE_DOWN ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.MOUSE_UP ) );
			assertFalse( buttonGraphic.hasEventListener( FrameButtonEvent.DISABLED ) );
			assertFalse( buttonGraphic.hasEventListener( FrameButtonEvent.ENABLED ) );
		}
		
		[Test(expects="ReferenceError")]
		public function test_constructor_with_no_label_text_field() : void
		{
			var buttonGraphic : MovieClip = new MovieClip();
			new LabelTextController( buttonGraphic, "text" );
		}
		
		[Test]
		public function test_constructor_with_no_label_text_and_no_label_text_field() : void
		{
			var buttonGraphic : MovieClip = new MovieClip();
			var labelTextDecorator : LabelTextController = new LabelTextController( buttonGraphic, "" );
			
			assertEquals( "unexpected value for singleLineOffsetY", 7, labelTextDecorator.singleLineOffsetY );
			
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.ROLL_OVER ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.ROLL_OUT ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.MOUSE_DOWN ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.MOUSE_UP ) );
			assertFalse( buttonGraphic.hasEventListener( FrameButtonEvent.DISABLED ) );
			assertFalse( buttonGraphic.hasEventListener( FrameButtonEvent.ENABLED ) );
		}

		[Test]
		public function test_dispose() : void
		{
			var buttonGraphic : MovieClip = new ExampleLabelButton();
			var labelTextDecorator : LabelTextController = new LabelTextController( buttonGraphic, "text" );
			
			labelTextDecorator.dispose();
			
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.ROLL_OVER ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.ROLL_OUT ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.MOUSE_DOWN ) );
			assertFalse( buttonGraphic.hasEventListener( MouseEvent.MOUSE_UP ) );
			assertFalse( buttonGraphic.hasEventListener( FrameButtonEvent.DISABLED ) );
			assertFalse( buttonGraphic.hasEventListener( FrameButtonEvent.ENABLED ) );
		}
	}
}