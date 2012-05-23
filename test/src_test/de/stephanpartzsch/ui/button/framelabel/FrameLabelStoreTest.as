package de.stephanpartzsch.ui.button.framelabel
{
	import de.stephanpartzsch.ui.button.framelabel.enum.LabelName;
	import de.stephanpartzsch.ui.button.graphic.StandardTestButton;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;




	public class FrameLabelStoreTest
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
			new FrameLabelStore( null );
		}

		[Test]
		public function test_get_label_for_name() : void
		{
			var frameLabelStore : FrameLabelStore = new FrameLabelStore( movieClip );

			var label : Label = frameLabelStore.getLabelForName( LabelName.OVER );

			assertEquals( "unexpected start frame", 21, label.startFrame );
			assertEquals( "unexpected end frame", 30, label.endFrame );
			assertEquals( "unexpected label length", 10, label.length );
		}

		[Test(expects="ArgumentError")]
		public function test_get_label_for_wrong_name() : void
		{
			var frameLabelStore : FrameLabelStore = new FrameLabelStore( movieClip );

			frameLabelStore.getLabelForName( LabelName.SELECTED_CLICK );
		}

		[Test]
		public function test_does_label_exist_for_name() : void
		{
			var frameLabelStore : FrameLabelStore = new FrameLabelStore( movieClip );

			var doesLabelExist : Boolean = frameLabelStore.doesLabelExistForName( LabelName.OVER );

			assertTrue( doesLabelExist );
		}

		[Test]
		public function test_does_label_exist_for_wrong_name() : void
		{
			var frameLabelStore : FrameLabelStore = new FrameLabelStore( movieClip );

			var doesLabelExist : Boolean = frameLabelStore.doesLabelExistForName( LabelName.SELECTED_CLICK );

			assertFalse( doesLabelExist );
		}

		[Test]
		public function test_get_all_labels() : void
		{
			var frameLabelStore : FrameLabelStore = new FrameLabelStore( movieClip );
			
			var expectedLabels : Dictionary = new Dictionary();
			expectedLabels["default"] = new Label( 1, 10 );
			expectedLabels["out"] = new Label( 11, 20 );
			expectedLabels["over"] = new Label( 21, 30 );
			
			var allLabels : Dictionary = frameLabelStore.getAllLabels();
			
			var expectedLabel : Label;
			var currentLabel : Label;
			for( var key : String in expectedLabels ) 
			{
				expectedLabel = expectedLabels[key] as Label;
				currentLabel = allLabels[key] as Label;
				
				assertEquals( "unexpeted start frame of label", expectedLabel.startFrame, currentLabel.startFrame );
				assertEquals( "unexpeted end frame of label", expectedLabel.endFrame, currentLabel.endFrame );
				assertEquals( "unexpeted length of label", expectedLabel.length, currentLabel.length );	
			}
		}
			
		[Test(expects="TypeError")]
		public function test_dispose() : void
		{
			var frameLabelStore : FrameLabelStore = new FrameLabelStore( movieClip );
			
			frameLabelStore.dispose();
			
			frameLabelStore.getLabelForName( LabelName.OVER );
		}
	}
}