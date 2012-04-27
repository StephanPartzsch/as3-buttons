package de.stephanpartzsch.ui.button.framelabel
{
	import org.flexunit.asserts.assertEquals;
	import de.stephanpartzsch.ui.button.label.Label;
	
	public class LabelTest
	{
		[Test(expects="ArgumentError")]
		public function test_constructor_with_start_frame_after_end_frame() : void
		{
			new Label( 100, 30 );
		}

		[Test]
		public function test_get_start_frame() : void
		{
			var label : Label = new Label( 20, 30 );
			
			assertEquals( "unexpected start frame", 20, label.startFrame );
		}
		
		[Test]
		public function test_get_end_frame() : void
		{
			var label : Label = new Label( 20, 30 );
			
			assertEquals( "unexpected end frame", 30, label.endFrame );
		}

		[Test]
		public function test_get_label_length() : void
		{
			var label : Label = new Label( 20, 30 );
			
			assertEquals( "unexpected length of label", 11, label.length );
		}
	}
}