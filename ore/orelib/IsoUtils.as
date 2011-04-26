package ore.orelib {
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class IsoUtils {
		public static const TRUE_SCALE:Number = Math.cos( -30 * Math.PI / 180) * Math.SQRT2;
		
		public static function isoToScreen(iso:Vector3D, out:Point = null):Point {
			out ||= new Point(0, 0);
			out.x = iso.x + iso.z;
			out.y = (iso.x - iso.z) / 2 + iso.y;
			return out;
		}
		
		public static function screenToIso(screen:Point, out:Vector3D = null):Vector3D {
			out ||= new Vector3D(0, 0, 0);
			out.x = (screen.x / 2 + screen.y) - out.y;
			out.z = (screen.x / 2 - screen.y) + out.y;
			return out;
		}
		
		public static function compareDepth(a:Vector3D, b:Vector3D):Number {
			return ((a.x - a.y - a.z) > (b.x - b.y - b.z)) ? 1 : -1;
		}
	}
}