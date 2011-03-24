package ore.orelib {
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	/**
	 * com.bit101.components.PushButton クラス風のボタンです。
	 * @see	http://www.minimalcomps.com/
	 */
	public class Button extends Sprite {
		private var _base:Sprite;
		private var _faceContainer:Sprite;
		private var _face:DisplayObject;
		
		/** 引数で指定した値に設定された Button の新しいインスタンスを生成する Creation Method です。 */
		public static function createFrom(x:int, y:int, width:int, height:int, face:DisplayObject, enabled:Boolean = true):Button {
			var button:Button = new Button(width, height);
			button.x = x;
			button.y = y;
			button.setFace(face);
			button.enabled = enabled;
			return button;
		}
		
		public function Button(width:int, height:int) {
			addChild(_base = createBase(width, height));
			_base.addChild(_faceContainer = new Sprite());
			_faceContainer.addChild(_face = new Shape());
			buttonMode = mouseEnabled = true;
			mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function createBase(width:int, height:int):Sprite {
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xC0C0C0);
			sp.graphics.drawRect(0, 0, width, height);
			sp.graphics.endFill();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, Math.PI / 2);
			sp.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE0E0E0], [1, 1], [0, 255], matrix);
			sp.graphics.drawRect(1, 1, width - 2, height - 2);
			sp.graphics.endFill();
			return sp;
		}
		
		private function mouseDownHandler(event:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			_base.filters = [new DropShadowFilter(2, 45, 0x808080, 0.5, 1, 1, 1, 1, true)];
			_faceContainer.x = _faceContainer.y = 1;
		}
		
		private function mouseUpHandler(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			_base.filters = [];
			_faceContainer.x = _faceContainer.y = 0;
		}
		
		/**
		 * ボタン上に表示する表示オブジェクトを設定します。
		 * @param	value	ボタン上に表示する表示オブジェクトです。
		 */
		public function setFace(value:DisplayObject):void {
			if (!value) { return; }
			_faceContainer.removeChild(_face);
			_face = value;
			_face.x = (width - _face.width) / 2;
			_face.y = (height - _face.height) / 2;
			_faceContainer.addChild(_face);
		}
		
		/** ボタンのクリック操作が有効かどうかを示す値を取得または設定します。 */
		public function get enabled():Boolean { return mouseEnabled; }
		public function set enabled(value:Boolean):void {
			mouseEnabled = value;
			var colorMultiplier:Number = (mouseEnabled) ? 1 : 0.7;
			_base.transform.colorTransform = new ColorTransform(colorMultiplier, colorMultiplier, colorMultiplier);
		}
	}
}