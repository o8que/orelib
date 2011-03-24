package ore.orelib {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Button extends Sprite {
		private var _base:Sprite;
		private var _faceContainer:Sprite;
		private var _face:DisplayObject;
		
		private var _pressed:Boolean;
		private var _enabled:Boolean;
		private var _selected:Boolean;
		
		public static function createFrom(x:int, y:int, width:int, height:int, face:DisplayObject):Button {
			var button:Button = new Button(width, height);
			button.x = x;
			button.y = y;
			button.face = face;
			return button;
		}
		
		public function Button(width:int, height:int) {
			addChild(_base = new Sprite());
			_base.addChild(_faceContainer = createFaceContainer(1, 1, width - 2, height - 2));
			_faceContainer.addChild(_face = new Shape());
			
			_pressed = false;
			_enabled = true;
			_selected = false;
		}
		
		private function createFaceContainer(x:int, y:int, width:int, height:int):Sprite {
			var sp:Sprite = new Sprite();
			sp.x = x;
			sp.y = y;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, Math.PI / 2);
			sp.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE0E0E0], [1, 1], [0, 255], matrix);
			sp.graphics.drawRect(0, 0, width, height);
			sp.graphics.endFill();
			return sp;
		}
		
		public function set face(value:DisplayObject):void {
			_faceContainer.removeChild(_face);
			_faceContainer.addChild(_face = value);
		}
	}
}
/*
package ore.orelib {
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Button extends Sprite {
		private var _size:Point;
		private var _border:Shape;
		private var _background:Shape;
		private var _faceContainer:Sprite;
		private var _face:DisplayObject;
		private var _facePosition:Point;
		private var _pressed:Boolean;
		
		private var _selected:Boolean;
		private var _enabled:Boolean;
		
		public function Button(width:int, height:int) {
			_size = new Point(width, height);
			addChild(_border = new Shape());
			addChild(_background = new Shape());
			addChild(_faceContainer = new Sprite());
			_faceContainer.addChild(_face = new Shape());
			_facePosition = new Point(0, 0);
			_pressed = false;
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(_size.x - 2, _size.y - 2, Math.PI / 2, 1, 1);
			_background.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE0E0E0], [1, 1], [0, 255], matrix);
			_background.graphics.drawRect(1, 1, _size.x - 2, _size.y - 2);
			_background.graphics.endFill();
			
			selected = false;
			enabled = true;
			
			mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function mouseDownHandler(event:MouseEvent):void {
			_pressed = true;
			draw();
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseUpHandler(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			_pressed = false;
			draw();
		}
		
		private static const DOWN:Array = [new DropShadowFilter(1, 45, 0x404040, 0.5, 1, 1, 1, 1, true)];
		private static const UP:Array = [];
		private static const NORMAL:ColorTransform = new ColorTransform(1, 1, 1);
		private static const DISABLED:ColorTransform = new ColorTransform(0.7, 0.7, 0.7);
		
		private function draw():void {
			_border.graphics.clear();
			_border.graphics.beginFill((_selected) ? 0xFFFF00 : 0xC0C0C0);
			_border.graphics.drawRect(0, 0, _size.x, _size.y);
			_border.graphics.endFill();
			
			_background.filters = (_pressed) ? DOWN : UP;
			
			_face.x = _facePosition.x + int(_pressed);
			_face.y = _facePosition.y + int(_pressed);
			
			transform.colorTransform = (_enabled) ? NORMAL : DISABLED;
		}
		
		public function setFace(face:DisplayObject):void {
			_faceContainer.removeChild(_face);
			_face = face;
			_face.x = _facePosition.x = (_size.x - _face.width) / 2;
			_face.y = _facePosition.y = (_size.y - _face.height) / 2;
			_faceContainer.addChild(_face);
		}
		
		public function get selected():Boolean { return _selected; }
		public function get enabled():Boolean { return _enabled; }
		
		public function set selected(value:Boolean):void {
			_selected = value;
			draw();
		}
		public function set enabled(value:Boolean):void {
			_enabled = buttonMode = mouseEnabled = value;
			draw();
		}
	}
}
*/