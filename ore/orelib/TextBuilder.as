package ore.orelib {
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class TextBuilder {
		public static const ALIGN_LEFT:String = "left";
		public static const ALIGN_RIGHT:String = "right";
		public static const ALIGN_CENTER:String = "center";
		
		public static var deviceFonts:Boolean = false;
		
		private var _posX:Number, _posY:Number, _width:Number, _height:Number;
		private var _background:Boolean, _backgroundColor:uint, _border:Boolean, _borderColor:uint;
		private var _fontName:String, _embedFonts:Boolean, _advancedAntiAlias:Boolean;
		private var _fontSize:int, _fontColor:uint, _bold:Boolean;
		private var _textBorder:Boolean, _textBorderColor:uint, _textBorderBlur:Number, _textBorderStrength:Number;
		private var _align:String, _autoSizeEnabled:Boolean, _autoCorrectPositionY:Boolean, _wordWrap:Boolean;
		
		public function TextBuilder() {clear();}
		
		public function clear():TextBuilder {
			_posX = 0; _posY = 0; _width = 100; _height = 100;
			_background = false; _backgroundColor = 0xffffff; _border = false; _borderColor = 0x000000;
			_fontName = "Arial"; _embedFonts = false; _advancedAntiAlias = false; _fontSize = 12; _fontColor = 0x000000; _bold = false;
			_textBorder = false; _textBorderColor = 0xffff00; _textBorderBlur = 4; _textBorderStrength = 2;
			_align = TextBuilder.ALIGN_LEFT; _autoSizeEnabled = false; _autoCorrectPositionY = false; _wordWrap = false;
			return this;
		}
		
		public function position(x:Number, y:Number, isRelative:Boolean = false):TextBuilder { if (isRelative) { _posX += x; _posY += y; } else { _posX = x; _posY = y; } return this; }
		public function size(width:Number, height:Number):TextBuilder { _width = width; _height = height; return this; }
		public function background(enabled:Boolean, color:uint = 0xffffff):TextBuilder { _background = enabled; _backgroundColor = color; return this; }
		public function border(enabled:Boolean, color:uint = 0x000000):TextBuilder { _border = enabled; _borderColor = color; return this; }
		public function font(name:String, embed:Boolean = false, advancedAntiAlias:Boolean = false):TextBuilder {
			if (deviceFonts) { return this; }
			_fontName = name;_embedFonts = embed;_advancedAntiAlias = advancedAntiAlias;return this;
		}
		public function fontSize(size:int):TextBuilder { _fontSize = size; return this; }
		public function fontColor(color:uint):TextBuilder { _fontColor = color; return this; }
		public function bold(enabled:Boolean = true):TextBuilder { _bold = enabled; return this; }
		public function textBorder(enabled:Boolean, color:uint = 0xffff00, blur:Number = 4, strength:Number = 2):TextBuilder { _textBorder = enabled; _textBorderColor = color; _textBorderBlur = blur; _textBorderStrength = strength; return this; }
		public function align(value:String = TextBuilder.ALIGN_LEFT):TextBuilder { _align = value; return this; }
		public function autoSize(enabled:Boolean = true, correctsY:Boolean = true):TextBuilder { _autoSizeEnabled = enabled; _autoCorrectPositionY = correctsY; return this; }
		public function wordWrap(enabled:Boolean = true):TextBuilder { _wordWrap = enabled; return this; }
		
		public function build(text:String):TextField {
			var textField:TextField = new TextField();
			
			textField.x = _posX;
			textField.y = _posY;
			textField.width = _width;
			textField.height = _height;
			
			var format:TextFormat = new TextFormat(_fontName, _fontSize, _fontColor, _bold);
			if (_autoSizeEnabled) {
				switch(_align) {
					case TextBuilder.ALIGN_LEFT: { textField.autoSize = TextFieldAutoSize.LEFT; break; }
					case TextBuilder.ALIGN_RIGHT: { textField.autoSize = TextFieldAutoSize.RIGHT; break; }
					case TextBuilder.ALIGN_CENTER: { textField.autoSize = TextFieldAutoSize.CENTER; break; }
				}
			}else {
				switch(_align) {
					case TextBuilder.ALIGN_LEFT: { format.align = TextFormatAlign.LEFT; break; }
					case TextBuilder.ALIGN_RIGHT: { format.align = TextFormatAlign.RIGHT; break; }
					case TextBuilder.ALIGN_CENTER: { format.align = TextFormatAlign.CENTER; break; }
				}
			}
			
			textField.embedFonts = _embedFonts;
			textField.antiAliasType = (_advancedAntiAlias ? AntiAliasType.ADVANCED : AntiAliasType.NORMAL);
			textField.defaultTextFormat = format;
			textField.text = text;
			
			if (textField.background = _background) { textField.backgroundColor = _backgroundColor; }
			if (textField.border = _border) { textField.borderColor = _borderColor; }
			if (_textBorder) { textField.filters = [new GlowFilter(_textBorderColor, 1, _textBorderBlur, _textBorderBlur, _textBorderStrength)]; }
			if (!(textField.wordWrap = _wordWrap) && _autoCorrectPositionY) { textField.y += Math.max(0, Math.ceil((_height - (textField.textHeight + 4)) / 2)); }
			textField.mouseEnabled = textField.selectable = false;
			
			return textField;
		}
		
		public function clone():TextBuilder {
			var clone:TextBuilder = new TextBuilder();
			clone._posX = _posX; clone._posY = _posY; clone._width = _width; clone._height = _height;
			clone._background = _background; clone._backgroundColor = _backgroundColor; clone._border = _border; clone._borderColor = _borderColor;
			clone._fontName = _fontName; clone._embedFonts = _embedFonts; clone._advancedAntiAlias = _advancedAntiAlias;
			clone._fontSize = _fontSize; clone._fontColor = _fontColor; clone._bold = _bold;
			clone._textBorder = _textBorder; clone._textBorderColor = _textBorderColor; clone._textBorderBlur = _textBorderBlur; clone._textBorderStrength = _textBorderStrength;
			clone._align = _align; clone._autoSizeEnabled = _autoSizeEnabled; clone._autoCorrectPositionY = _autoCorrectPositionY; clone._wordWrap = _wordWrap;
			return clone;
		}
	}
}