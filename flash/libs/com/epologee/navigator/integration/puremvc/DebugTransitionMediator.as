package com.epologee.navigator.integration.puremvc {
	import com.epologee.navigator.features.display.DebugConsole;
	import com.epologee.navigator.namespaces.hidden;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;


	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class DebugTransitionMediator extends TimelineMediator {
		public static const NAME : String = getQualifiedClassName(DebugTransitionMediator);
		private var _alignMode : String;
		private var _display : DebugConsole;

		/**
		 * @param inContainer pass in a Sprite, otherwise the container getter will fail.
		 */
		public function DebugTransitionMediator(inTimeline : Sprite, inAlignMode : String = "BR") {
			super(NAME, inTimeline);
			_alignMode = inAlignMode;
		}

		override public function onRegister() : void {
			var np : NavigationProxy = NavigationProxy(facade.retrieveProxy(NavigationProxy.NAME));
			_display = new DebugConsole(np.hidden::navigator, _alignMode);

			timeline.addChild(_display);
		}
	}
}