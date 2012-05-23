package de.stephanpartzsch.ui.button.framelabel
{
	import de.stephanpartzsch.ui.button.event.FrameLabelEvent;
	import de.stephanpartzsch.ui.button.framelabel.enum.LabelName;
	import de.stephanpartzsch.ui.button.graphic.StandardTestButton;
	import flash.display.MovieClip;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;

	public class FrameLabelControllerTest
	{
		private var movieClip : MovieClip;
		
		[Before]
		public function run_before_every_test() : void
		{
			movieClip = new StandardTestButton();
		}
		
		[Test(expects="ArgumentError")]
		public function test_constructor_with_null() : void
		{
			new FrameLabelController( null );
		}
		
		[Test(async)]
		public function test_label_start() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			
			frameLabelController.addEventListener( FrameLabelEvent.FRAME_LABEL_START, Async.asyncHandler( this, handleLabelStart, 200 ) );
			
			frameLabelController.gotoAndPlay( LabelName.OVER );
		}

		private function handleLabelStart( event : FrameLabelEvent, passThroughData : Object ) : void
		{
			assertEquals( "unexpected label name", LabelName.DEFAULT, event.currentFrameLabelName );
		}
		
		[Test(async)]
		public function test_label_end() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );

			frameLabelController.addEventListener( FrameLabelEvent.FRAME_LABEL_END, Async.asyncHandler( this, handleLabelEnd, 200 ) );
			
			frameLabelController.gotoAndPlay( LabelName.OVER );
		}
		
		private function handleLabelEnd( event : FrameLabelEvent, passThroughData : Object ) : void
		{
			assertEquals( "unexpected label name", LabelName.OVER, event.currentFrameLabelName );
		}
			
		[Test(expects="TypeError")]
		public function test_dispose() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			
			frameLabelController.dispose();
			
			frameLabelController.gotoAndPlay( LabelName.OVER );
		}
			
		[Test]
		public function test_does_label_exist_for_name() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			
			var doesLabelExist : Boolean = frameLabelController.doesLabelExistForName( LabelName.OVER );
			
			assertTrue( doesLabelExist );
		}
			
		[Test]
		public function test_does_label_exist_for_wrong_name() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			
			var doesLabelExist : Boolean = frameLabelController.doesLabelExistForName( LabelName.SELECTED_CLICK );
			
			assertFalse( doesLabelExist );
		}
			
		[Test]
		public function test_goto_and_stop() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			movieClip.stop();
			
			frameLabelController.gotoAndStop( LabelName.OUT );
			
			assertEquals( "unexpected current label of MovieClip", LabelName.OUT, movieClip.currentLabel );
		}
			
		[Test]
		public function test_goto_and_stop_from_inside_label() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			movieClip.gotoAndStop( 5 );
			
			frameLabelController.gotoAndStop( LabelName.OUT );
			
			assertEquals( "unexpected current label of MovieClip", LabelName.OUT, movieClip.currentLabel );
		}
			
		[Test]
		public function test_goto_and_stop_to_current_label() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			frameLabelController.gotoAndStop( LabelName.OUT );
			
			frameLabelController.gotoAndStop( LabelName.OUT );
			
			assertEquals( "unexpected current label of MovieClip", LabelName.OUT, movieClip.currentLabel );
		}
			
		[Test(expects="ArgumentError")]
		public function test_goto_and_stop_to_wrong_label() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			movieClip.stop();
			
			frameLabelController.gotoAndStop( LabelName.SELECTED_OUT );
		}
			
		[Test]
		public function test_goto_and_stop_to_wrong_label_with_fallback() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			movieClip.stop();
			
			frameLabelController.gotoAndStop( LabelName.SELECTED_OUT, LabelName.DEFAULT);

			assertEquals( "unexpected current label of MovieClip", LabelName.DEFAULT, movieClip.currentLabel );
		}
			
		[Test]
		public function test_goto_and_play() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			
			frameLabelController.gotoAndPlay( LabelName.OUT );
			movieClip.stop();
			
			assertEquals( "unexpected current frame of MovieClip", 20, movieClip.currentFrame );
		}

		[Test]
		public function test_goto_and_play_from_inside_label() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			movieClip.gotoAndStop( 5 );
			
			frameLabelController.gotoAndPlay( LabelName.OUT );
			movieClip.stop();
			
			assertEquals( "unexpected current frame of MovieClip", 16, movieClip.currentFrame );
		}
			
		[Test]
		public function test_goto_and_play_to_current_label() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			frameLabelController.gotoAndStop( LabelName.OUT );
			
			frameLabelController.gotoAndPlay( LabelName.OUT );
			movieClip.stop();
			
			assertEquals( "unexpected current frame of MovieClip", 11, movieClip.currentFrame );
		}
			
		[Test(expects="ArgumentError")]
		public function test_goto_and_play_to_wrong_label() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			movieClip.stop();
			
			frameLabelController.gotoAndPlay( LabelName.SELECTED_OUT );
		}
			
		[Test]
		public function test_goto_and_play_to_wrong_label_with_fallback() : void
		{
			var frameLabelController : FrameLabelController = new FrameLabelController( movieClip );
			movieClip.stop();
			
			frameLabelController.gotoAndStop( LabelName.SELECTED_OUT, LabelName.DEFAULT);
			movieClip.stop();

			assertEquals( "unexpected current label of MovieClip", LabelName.DEFAULT, movieClip.currentLabel );
		}
	}
}