package ore.orelib {
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class ExternalImageLoader extends EventDispatcher {
		private var _content:BitmapData;
		private var _temp1:Loader;
		private var _temp2:Loader;
		
		public function ExternalImageLoader() {
			_content = null; _temp1 = new Loader(); _temp2 = new Loader();
		}
		
		public function load(url:String):void {
			_temp1.contentLoaderInfo.addEventListener(Event.INIT, temp1Loaded);
			_temp1.load(new URLRequest(url), new LoaderContext(true));
		}
		
		private function temp1Loaded(event:Event):void {
			event.target.removeEventListener(Event.INIT, temp1Loaded);
			_content = new BitmapData(int(_temp1.width), int(_temp1.height), true, 0x00ffffff);
			_temp2.contentLoaderInfo.addEventListener(Event.INIT, temp2Loaded);
			_temp2.loadBytes(_temp1.contentLoaderInfo.bytes);
		}
		
		private function temp2Loaded(event:Event):void {
			event.target.removeEventListener(Event.INIT, temp2Loaded);
			_content.draw(_temp2); _temp1.unload(); _temp2.unload();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get content():BitmapData { return _content; }
	}
}