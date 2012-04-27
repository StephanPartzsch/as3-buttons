package de.stephanpartzsch.ui.button.error
{
	import org.flexunit.asserts.assertEquals;

	import flash.display.MovieClip;
	
	public class MissingLabelErrorTest
	{
		[Test]
		public function test_constructor() : void
		{
			var missingLabelError : MissingLabelError = new MissingLabelError( ["LABEL_ONE", "LABEL_TWO", "LABEL_THREE"], new MovieClip() );
		
			assertEquals( "unexpected error message", "One of the required frame labels (LABEL_ONE, LABEL_TWO, LABEL_THREE) is missing for the button instance ([object MovieClip]) of type FrameButton", missingLabelError.message );
		}

		[Test]
		public function test_constructor_with_empty_array() : void
		{
			var missingLabelError : MissingLabelError = new MissingLabelError( [], new MovieClip() );
		
			assertEquals( "unexpected error message", "One of the required frame labels () is missing for the button instance ([object MovieClip]) of type FrameButton", missingLabelError.message );
		}
	}
}