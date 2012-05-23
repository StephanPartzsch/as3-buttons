package
{
	import de.stephanpartzsch.ui.button.FrameButtonTest;
	import de.stephanpartzsch.ui.button.ToggleFrameButtonTest;
	import de.stephanpartzsch.ui.button.error.MissingLabelErrorTest;
	import de.stephanpartzsch.ui.button.framelabel.FrameLabelControllerTest;
	import de.stephanpartzsch.ui.button.framelabel.FrameLabelStoreTest;
	import de.stephanpartzsch.ui.button.framelabel.LabelTest;
	import de.stephanpartzsch.ui.button.labeltext.LabelTextControllerTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ButtonsTestSuite
	{
		public var missingLabelErrorTest : MissingLabelErrorTest;

		public var frameLabelControllerTest : FrameLabelControllerTest;
		public var frameLabelStore : FrameLabelStoreTest;
		public var labelTest : LabelTest;
		public var labelTextControllerTest : LabelTextControllerTest;
	
		public var frameButtonTest : FrameButtonTest;
		public var toggleFrameButtonTest : ToggleFrameButtonTest;
	}
}