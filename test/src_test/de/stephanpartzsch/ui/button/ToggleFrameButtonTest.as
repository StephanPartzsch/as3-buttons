package de.stephanpartzsch.ui.button
{
	import de.stephanpartzsch.ui.button.framelabel.enum.LabelName;
	import de.stephanpartzsch.ui.button.graphic.FaultyToggleTestButton;
	import de.stephanpartzsch.ui.button.graphic.StandardToggleTestButton;
	import flash.display.MovieClip;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class ToggleFrameButtonTest
	{
		[Test]
		public function test_constructor() : void
		{
			var movieClip : MovieClip = new StandardToggleTestButton();
			var toggleFrameButton : ToggleFrameButton = new ToggleFrameButton( movieClip );
			
			assertTrue( toggleFrameButton.buttonMode );
			assertFalse( toggleFrameButton.mouseChildren );
			assertTrue( toggleFrameButton.enabled );
			assertFalse( toggleFrameButton.selected );
		}
		
		[Test(expects="ArgumentError")]
		public function test_constructor_with_null() : void
		{
			new ToggleFrameButton( null );
		}

		[Test(expects="ArgumentError")]
		public function test_static_creation_with_null() : void
		{
			ToggleFrameButton.createFromInstance( null );
		}
		
		[Test(expects="de.stephanpartzsch.ui.button.error.MissingLabelError")]
		public function test_constructor_with_faulty_button() : void
		{
			new ToggleFrameButton( new FaultyToggleTestButton() );
		}
		
		[Test(expects="de.stephanpartzsch.ui.button.error.MissingLabelError")]
		public function test_static_creation_with_faulty_button_class() : void
		{
			ToggleFrameButton.createFromClass( FaultyToggleTestButton );
		}
		
		[Test(expects="de.stephanpartzsch.ui.button.error.MissingLabelError")]
		public function test_static_creation_with_faulty_button_instance() : void
		{
			ToggleFrameButton.createFromInstance( new FaultyToggleTestButton() );
		}
	
		[Test]
		public function test_set_selected() : void
		{
			var movieClip : MovieClip = new StandardToggleTestButton();
			var toggleFrameButton : ToggleFrameButton = new ToggleFrameButton( movieClip );
			
			toggleFrameButton.selected = true;
			
			assertTrue( toggleFrameButton.selected );
			assertEquals( "unexpected frame label name", LabelName.SELECTED_DEFAULT, toggleFrameButton.currentLabel );
		}
	
		[Test]
		public function test_set_unselected() : void
		{
			var movieClip : MovieClip = new StandardToggleTestButton();
			var toggleFrameButton : ToggleFrameButton = new ToggleFrameButton( movieClip );
			
			toggleFrameButton.selected = true;
			toggleFrameButton.selected = false;
			
			assertFalse( toggleFrameButton.selected );
			assertEquals( "unexpected frame label name", LabelName.DEFAULT, toggleFrameButton.currentLabel );
		}
	}
}