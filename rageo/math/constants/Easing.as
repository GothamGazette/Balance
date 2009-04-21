package rageo.math.constants 
{
	include "../index.as"
	
	public class Easing {
		
			// LINEAR
		public static function linear(t, b, c, d) 
		{
			//var c = c - b
			return c*t/d+b
		}
		
		// EASE IN
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number 
		{
			//var c = c - b
			return c*(t /= d)*t+b
		}
		
		// EASE OUT
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number 
		{
			//var c = c - b
			return -c*(t /= d)*(t-2)+b
		}
		
		// EASE IN OUT
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number 
		{
			//var c = c - b
			return (t /= d/2)<1 ? c/2*t*t+b : -c/2*((--t)*(t-2)-1)+b
		}
		
		// EASE IN CIRC
		public static function easeInCirc(t, b, c, d) 
		{
			//var c = c - b
			return -c*(Math.sqrt(1-(t /= d)*t)-1)+b
		}
		
		// EASE OUT CIRC
		public static function easeOutCirc(t, b, c, d) 
		{
			//var c = c - b
			return c*Math.sqrt(1-(t=t/d-1)*t)+b
		}
		
		// EASE IN OUT CIRC
		public static function easeInOutCirc(t, b, c, d) 
		{
			//var c = c - b
			return (t /= d/2)<1 ? -c/2*(Math.sqrt(1-t*t)-1)+b : c/2*(Math.sqrt(1-(t -= 2)*t)+1)+b
		}
		
		// EASE IN ELASTIC
		public static function easeInElastic(t, b, c, d, a=null, p=null) 
		{
			//var c = c - b
			if (t == 0) {
				return b
			}
			if ((t /= d) == 1) {
				return b+c
			}
			if (!p) {
				p = d*.3
			}
			
			var s
			if (a<Math.abs(c) || a == null) {
				a = c
				s = p/4
			} else {
				s = p/(2*Math.PI)*Math.asin(c/a)
			}
			return -(a*Math.pow(2, 10*(t -= 1))*Math.sin((t*d-s)*(2*Math.PI)/p))+b
		}
		
		// EASE OUT ELASTIC
		public static function easeOutElastic(t, b, c, d, a=null, p=null) 
		{
			//var c = c - b
			if (t == 0) {
				return b
			}
			if ((t /= d) == 1) {
				return b+c
			}
			if (!p) {
				p = d*.3
			}
			var s
			if (a<Math.abs(c) || a == null) {
				a = c
				s = p/4
			} else {
				s = p/(2*Math.PI)*Math.asin(c/a)
			}
			return a*Math.pow(2, -10*t)*Math.sin((t*d-s)*(2*Math.PI)/p)+c+b
		}
		
		// EASE IN OUT ELASTIC
		public static function easeInOutElastic(t, b, c, d, a, p) 
		{
			//var c = c - b
			if (t == 0) {
				return b
			}
			if ((t /= d/2) == 2) {
				return b+c
			}
			if (!p) {
				p = d*(.3*1.5)
			}
			var s
			if (a<Math.abs(c) || a == null) {
				a = c
				s = p/4
			} else {
				s = p/(2*Math.PI)*Math.asin(c/a)
			}
			if (t<1) {
				return -.5*(a*Math.pow(2, 10*(t -= 1))*Math.sin((t*d-s)*(2*Math.PI)/p))+b
			}
			return a*Math.pow(2, -10*(t -= 1))*Math.sin((t*d-s)*(2*Math.PI)/p)*.5+c+b
		}
		
		// EASE IN BOUNCE
		public static function easeInBounce(t, b, c, d) 
		{
			//var c = c - b
			return c-easeOutBounce(d-t, 0, c, d)+b
		}
		
		// EASE OUT BOUNCE
		public static function easeOutBounce(t, b, c, d) 
		{
			//var c = c - b
			if ((t /= d)<(1/2.75)) {
				return c*(7.5625*t*t)+b
			} else if (t<(2/2.75)) {
				return c*(7.5625*(t -= (1.5/2.75))*t+.75)+b
			} else if (t<(2.5/2.75)) {
				return c*(7.5625*(t -= (2.25/2.75))*t+.9375)+b
			} else {
				return c*(7.5625*(t -= (2.625/2.75))*t+.984375)+b
			}
		}
		
		// EASE IN OUT BOUNCE
		public static function easeInOutBounce(t, b, c, d) 
		{
			//var c = c - b
			if (t<d/2) {
				return easeInBounce(t*2, 0, c, d)*.5+b
			}
			return easeOutBounce(t*2-d, 0, c, d)*.5+c*.5+b
		}
		
		
		
	}
}
