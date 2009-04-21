
package rageo.tween.tweenlite {

	public class Tweenr {
	
		public static function to($target:Object, $duration:Number, $vars:Object):TweenLite {
			return new TweenMax ($target, $duration, $vars);
		}
		
		public static function fadeIn( target, duration = .3 , onComplete=null) {	
			target.visible = true
			target.alpha = 0
			to ( target, duration, {alpha:1, onComplete:onComplete} )	
		}
		
		public static function fadeOut( target, duration = .3 , onComplete=null) {
			target.visible = true
			to ( target, duration, {alpha:-.1, onComplete:onComplete} )	
		}

	}
	
}
