package ore.orelib {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	[Event(name = "complete", type = "flash.events.Event")]
	/** 外部画像を、アクセス可能な flash.display.BitmapData クラスとしてロードする際に使用します。 */
	public class ExternalImageLoader extends EventDispatcher {
		private var _usesHack:Boolean;
		private var _bitmapData:BitmapData;
		
		public function ExternalImageLoader() {
			_usesHack = true;
			_bitmapData = new BitmapData(1, 1, false, 0x000000);
		}
		
		public function load(url:String, usesHack:Boolean = true):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaded);
			loader.load(new URLRequest(url), new LoaderContext(!(_usesHack = usesHack)));
		}
		
		private function onLoaded(event:Event):void {
			event.target.removeEventListener(Event.INIT, onLoaded);
			if (_usesHack) {
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.INIT, onHacked);
				loader.loadBytes(event.target.bytes);
			}else {
				_bitmapData = event.target.loader.content.bitmapData;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function onHacked(event:Event):void {
			event.target.removeEventListener(Event.INIT, onHacked);
			var content:DisplayObject = event.target.loader.content;
			_bitmapData = new BitmapData(content.width, content.height, true, 0x00FFFFFF);
			_bitmapData.draw(content);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get bitmapData():BitmapData { return _bitmapData; }
	}
}