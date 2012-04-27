package de.stephanpartzsch.ui.button
{
	import org.flexunit.asserts.assertEquals;
	import de.stephanpartzsch.ui.button.graphic.FaultyTestButton;
	import de.stephanpartzsch.ui.button.graphic.StandardTestButton;

	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class FrameButtonTest
	{
		[Test]
		public function test_constructor() : void
		{
			var movieClip : MovieClip = new StandardTestButton();
			var frameButton : FrameButton = new FrameButton( movieClip );
			
			assertTrue( frameButton.buttonMode );
			assertFalse( frameButton.mouseChildren );
			assertTrue( frameButton.enabled );
		}
		
		[Test(expects="ArgumentError")]
		public function test_constructor_with_null() : void
		{
			new FrameButton( null );
		}
		
		[Test(expects="de.stephanpartzsch.ui.button.error.MissingLabelError")]
		public function test_constructor_with_faulty_button() : void
		{
			new FrameButton( new FaultyTestButton() );
		}

		[Test]
		public function test_static_creation_with_button_class() : void
		{
			var frameButton : FrameButton = FrameButton.createFromClass( StandardTestButton );
			assertEquals( "unexpected parent", frameButton, frameButton.parent );
		}

		[Test]
		public function test_static_creation_with_button_instance() : void
		{
			var movieClip : MovieClip = new StandardTestButton();
			var frameButton : FrameButton = FrameButton.createFromInstance( movieClip );
			assertEquals( "unexpected parent", null, frameButton.parent );
		}

		[Test(expects="ArgumentError")]
		public function test_static_creation_with_null() : void
		{
			FrameButton.createFromInstance( null );
		}

		[Test(expects="de.stephanpartzsch.ui.button.error.MissingLabelError")]
		public function test_static_creation_with_faulty_button_class() : void
		{
			FrameButton.createFromClass( FaultyTestButton );
		}
		
		[Test(expects="de.stephanpartzsch.ui.button.error.MissingLabelError")]
		public function test_static_creation_with_faulty_button_instance() : void
		{
			FrameButton.createFromInstance( new FaultyTestButton() );
		}
		
		[Test]
		public function test_set_enabled() : void
		{
			var movieClip : MovieClip = new StandardTestButton();
			var frameButton : FrameButton = new FrameButton( movieClip );
			
			frameButton.enabled = false;
			frameButton.enabled = true;
			
			assertTrue( "unexpected buttonMode", frameButton.buttonMode );
			assertTrue( "unexpected enabled state", frameButton.enabled );
		}
		
		[Test]
		public function test_set_disabled() : void
		{
			var movieClip : MovieClip = new StandardTestButton();
			var frameButton : FrameButton = new FrameButton( movieClip );
			
			frameButton.enabled = false;
			
			assertFalse( "unexpected buttonMode", frameButton.buttonMode );
			assertFalse( "unexpected enabled state", frameButton.enabled );
		}
		
		[Test]
		public function test_dispose() : void
		{
			var movieClip : MovieClip = new StandardTestButton();
			var frameButton : FrameButton = new FrameButton( movieClip );
			
			frameButton.dispose();
			
			assertFalse( movieClip.hasEventListener( MouseEvent.ROLL_OVER ) );			
			assertFalse( movieClip.hasEventListener( MouseEvent.ROLL_OUT ) );			
			assertFalse( movieClip.hasEventListener( MouseEvent.MOUSE_DOWN ) );			
			assertFalse( movieClip.hasEventListener( MouseEvent.MOUSE_UP ) );
			assertFalse( movieClip.hasEventListener( MouseEvent.CLICK ) );			
		}
	}
}