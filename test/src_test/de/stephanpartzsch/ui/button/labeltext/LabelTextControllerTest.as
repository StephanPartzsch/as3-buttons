package de.stephanpartzsch.ui.button.labeltext
{
	import de.stephanpartzsch.ui.button.event.FrameButtonEvent;
	import de.stephanpartzsch.ui.button.graphic.BigLabelButton;

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
			var buttonGraphic : MovieClip = new BigLabelButton();
			new LabelTextController( buttonGraphic, "text" );
			
			assertEquals( "unexpected text for label text field", "text", TextField( buttonGraphic["labelText"] ).text );
			assertEquals( "unexpected vertical position for label text field", 20, TextField( buttonGraphic["labelText"] ).y );
			
			assertTrue( buttonGraphic.hasEventListener( MouseEvent.ROLL_OVER ) );
			assertTrue( buttonGraphic.hasEventListener( MouseEvent.ROLL_OUT ) );
			assertTrue( buttonGraphic.hasEventListener( MouseEvent.MOUSE_DOWN ) );
			assertTrue( buttonGraphic.hasEventListener( MouseEvent.MOUSE_UP ) );
			assertTrue( buttonGraphic.hasEventListener( FrameButtonEvent.DISABLED ) );
			assertTrue( buttonGraphic.hasEventListener( FrameButtonEvent.ENABLED ) );
		}
		
		[Test]
		public function test_constructor_with_vertically_centered_text() : void
		{
			var buttonGraphic : MovieClip = new BigLabelButton();
			new LabelTextController( buttonGraphic, "text", true );
			
			assertEquals( "unexpected text for label text field", "text", TextField( buttonGraphic["labelText"] ).text );
			assertEquals( "unexpected vertical position for label text field", 60, TextField( buttonGraphic["labelText"] ).y );
			
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
			var buttonGraphic : MovieClip = new BigLabelButton();
			new LabelTextController( buttonGraphic, "" );
			
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
			new LabelTextController( buttonGraphic, "" );
			
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
			var buttonGraphic : MovieClip = new BigLabelButton();
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