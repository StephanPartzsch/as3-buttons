package
{
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;

	import flash.display.Sprite;

	public class TestRunner extends Sprite
	{
		private var core : FlexUnitCore;

		public function TestRunner()
		{
			VisualTestEnvironmentBuilder.getInstance( this );

			core = new FlexUnitCore();
			core.addListener( new TraceListener() );

			core.run( ButtonsTestSuite );
		}
	}
}