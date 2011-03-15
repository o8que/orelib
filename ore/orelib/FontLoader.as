package ore.orelib {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.text.Font;
	
	/** フォントの登録が完了した際に送出されます。 */
	[Event(name = "complete", type = "flash.events.Event")]
	/** ローカルテスト時に net.wonderfl.utils.FontLoader クラスの代わりに使用します。 */
	public class FontLoader extends EventDispatcher {
		private var _fontName:String;
		
		public function FontLoader() { }
		
		/**
		 * フォントを読み込んで登録します。
		 * @param	fontName
		 * ["Aqua","Azuki","Cinecaption","Mona","Sazanami","YSHandy","VLGothic","IPAGP","IPAM","UmeUgo","UmePms","Bebas"]
		 */
		public function load(fontName:String):void {
			_fontName = fontName;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onSWFLoaded);
			loader.load(new URLRequest("http://assets.wonderfl.net/static/fonts/" + _fontName + ".swf"));
		}
		
		private function onSWFLoaded(event:Event):void {
			event.target.removeEventListener(Event.INIT, onSWFLoaded);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, registerFont);
			loader.loadBytes(event.target.bytes);
		}
		
		private function registerFont(event:Event):void {
			event.target.removeEventListener(Event.INIT, registerFont);
			Font.registerFont(Class(event.target.applicationDomain.getDefinition("net.wonderfl.fonts." + _fontName + "_font")));
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}