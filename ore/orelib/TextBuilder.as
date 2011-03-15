package ore.orelib {
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/** 複雑な設定の flash.text.TextField クラスの生成を単純化します。 */
	public class TextBuilder {
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const CENTER:String = "center";
		
		private var _align:String;
		private var _autoSize:Boolean;
		private var _bold:Boolean;
		private var _filters:Array;
		private var _fontName:String;
		private var _sharpness:Number;
		private var _thickness:Number;
		private var _fontColor:uint;
		private var _fontSize:int;
		private var _pos:Point;
		private var _size:Point;
		
		public function TextBuilder() {
			_align = TextBuilder.LEFT;
			_autoSize = _bold = false;
			_filters = [];
			_fontName = null;
			_sharpness = _thickness = 0;
			_fontColor = 0x000000;
			_fontSize = 12;
			_pos = new Point(0, 0);
			_size = new Point(100, 100);
		}
		
		public function align(value:String):TextBuilder {
			_align = value;
			return this;
		}
		
		public function autoSize(enabled:Boolean = true):TextBuilder {
			_autoSize = enabled;
			return this;
		}
		
		public function bold(enabled:Boolean = true):TextBuilder {
			_bold = enabled;
			return this;
		}
		
		public function filters(value:Array):TextBuilder {
			_filters = value;
			return this;
		}
		
		public function font(name:String, sharpness:Number = 0, thickness:Number = 0):TextBuilder {
			_fontName = name;
			_sharpness = sharpness;
			_thickness = thickness;
			return this;
		}
		
		public function fontColor(value:uint):TextBuilder {
			_fontColor = value;
			return this;
		}
		
		public function fontSize(value:int):TextBuilder {
			_fontSize = value;
			return this;
		}
		
		public function pos(x:Number, y:Number, relative:Boolean = false):TextBuilder {
			_pos.x = ((relative) ? _pos.x : 0) + x;
			_pos.y = ((relative) ? _pos.y : 0) + y;
			return this;
		}
		
		public function size(width:Number, height:Number):TextBuilder {
			_size.x = width;
			_size.y = height;
			return this;
		}
		
		public function build(text:String):TextField {
			var tf:TextField = new TextField();
			var format:TextFormat = new TextFormat(_fontName, _fontSize, _fontColor, _bold);
			if (_fontName) {
				tf.embedFonts = true;
				tf.antiAliasType = AntiAliasType.ADVANCED;
				tf.gridFitType = (_align == TextBuilder.LEFT) ? GridFitType.PIXEL : GridFitType.SUBPIXEL;
				tf.sharpness = _sharpness;
				tf.thickness = _thickness;
			}
			if (_autoSize) {
				switch(_align) {
					case TextBuilder.LEFT: { tf.autoSize = TextFieldAutoSize.LEFT; break; }
					case TextBuilder.RIGHT: { tf.autoSize = TextFieldAutoSize.RIGHT; break; }
					case TextBuilder.CENTER: { tf.autoSize = TextFieldAutoSize.CENTER; break; }
				}
			}else {
				tf.width = _size.x;
				tf.height = _size.y;
				switch(_align) {
					case TextBuilder.LEFT: { format.align = TextFormatAlign.LEFT; break; }
					case TextBuilder.RIGHT: { format.align = TextFormatAlign.RIGHT; break; }
					case TextBuilder.CENTER: { format.align = TextFormatAlign.CENTER; break; }
				}
			}
			tf.defaultTextFormat = format;
			tf.text = text;
			tf.x = _pos.x;
			tf.y = _pos.y + ((_autoSize) ? Math.max(0, int((_size.y - (tf.textHeight + 4)) / 2)) : 0);
			tf.filters = _filters.concat();
			tf.mouseEnabled = tf.selectable = false;
			return tf;
		}
		
		public function clone():TextBuilder {
			return new TextBuilder().align(_align).autoSize(_autoSize).bold(_bold).filters(_filters)
			.font(_fontName, _sharpness, _thickness).fontColor(_fontColor).fontSize(_fontSize)
			.pos(_pos.x, _pos.y).size(_size.x, _size.y);
		}
	}
}