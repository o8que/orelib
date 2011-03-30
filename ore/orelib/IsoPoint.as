package ore.orelib {
	
	/** 等角投影の座標系の位置を表します。 */
	public class IsoPoint {
		private var _worldX:Number;
		private var _worldY:Number;
		private var _worldZ:Number;
		private var _screenX:Number;
		private var _screenY:Number;
		private var _screenZ:Number;
		private var _isValidWorld:Boolean;
		private var _isValidScreen:Boolean;
		
		/** 正確な高さに変換する際に用いる倍率補正値です。 */
		public static const TRUE_SCALE_Y:Number = Math.cos(-30 * Math.PI / 180) * Math.SQRT2;
		
		/** ワールド座標値から IsoPoint の新しいインスタンスを生成する Creation Method です。 */
		public static function createFromWorld(x:Number = 0, y:Number = 0, z:Number = 0):IsoPoint {
			var point:IsoPoint = new IsoPoint();
			point.x = x;
			point.y = y;
			point.z = z;
			return point;
		}
		
		/** スクリーン座標値から IsoPoint の新しいインスタンスを生成する Creation Method です。*/
		public static function createFromScreen(x:Number = 0, y:Number = 0):IsoPoint {
			var point:IsoPoint = new IsoPoint();
			point.screenX = x;
			point.screenY = y;
			return point;
		}
		
		public function IsoPoint() {
			_worldX = _worldY = _worldZ = _screenX = _screenY = _screenZ = 0;
			_isValidWorld = _isValidScreen = true;
		}
		
		private function validateWorld():void {
			if (_isValidWorld) { return; }
			_worldX = (_screenY + _screenX / 2) + _worldY;
			_worldZ = (_screenY - _screenX / 2) + _worldY;
			_screenZ = _worldX + _worldY + _worldZ;
			_isValidWorld = true;
		}
		
		private function validateScreen():void {
			if (_isValidScreen) { return; }
			_screenX = _worldX - _worldZ;
			_screenY = (_worldX + _worldZ) / 2 - _worldY;
			_screenZ = _worldX + _worldY + _worldZ;
			_isValidScreen = true;
		}
		
		/** ワールドの x 座標の値を取得または設定します。正方向は右下です。 */
		public function get x():Number { validateWorld(); return _worldX; }
		public function set x(value:Number):void { validateWorld(); _worldX = value; _isValidScreen = false; }
		
		/** ワールドの y 座標の値を取得または設定します。正方向は上です。 */
		public function get y():Number { validateWorld(); return _worldY; }
		public function set y(value:Number):void { validateWorld(); _worldY = value; _isValidScreen = false; }
		
		/** ワールドの z 座標の値を取得または設定します。正方向は左下です。 */
		public function get z():Number { validateWorld(); return _worldZ; }
		public function set z(value:Number):void { validateWorld(); _worldZ = value; _isValidScreen = false; }
		
		/** スクリーンの x 座標の値を取得または設定します。 */
		public function get screenX():Number { validateScreen(); return _screenX; }
		public function set screenX(value:Number):void { validateScreen(); _screenX = value; _isValidWorld = false; }
		
		/** スクリーンの y 座標の値を取得または設定します。 */
		public function get screenY():Number { validateScreen(); return _screenY; }
		public function set screenY(value:Number):void { validateScreen(); _screenY = value; _isValidWorld = false; }
		
		/** 深度の値を取得します。値が大きいほど手前にあることを示します。 */
		public function get depth():Number { return _screenZ; }
	}
}