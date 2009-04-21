package rageo.util
{	
	include "../index.as"
	
	public class Zoom {

		public static function zoom( target:MovieClip, ratio:Number, min = .1, max = 1.5, x = null, y = null) 
		{
			var x 				= 	Utils.or( x, target.width/2 )
			var y 				= 	Utils.or( y, target.height/2 )
			
			var nextwidth 		= 	target.width * ratio
			var nextheight 		= 	target.height * ratio
			
			var px 				= 	( x-target.x )/target.scaleX
			var py 				= 	( y-target.y )/target.scaleY
			
			
			target.scaleX 		= 	target.scaleX *= ratio
			
			target.scaleY 		= 	target.scaleX = Utils.constrain( target.scaleX, min, max )
			

			target.x 			= 	x-target.scaleX * px
			target.y 			= 	y-target.scaleY * py
			
			return ( Math.round( target.scaleX )+"%" )
		}

		
		public static function zoomTo( target:MovieClip, to, min = .1, max = 1.5, x = null, y = null ) 
		{
			var x 				= 	Utils.or( x, target.width/2 )
			var y 				= 	Utils.or( y, target.height/2 )
			
			var nextwidth 		= 	target.width * target.scaleX * to
			var nextheight 		= 	target.height * target.scaleY * to
			
			var px 				= 	( x-target.x )/target.scaleX
			var py 				= 	( y-target.y )/target.scaleY

			target.scaleY 		= 	target.scaleX = to
			target.x 			= 	x-target.scaleX * px
			target.y 			= 	y-target.scaleY * py
		}
		
		
		
		
	}
}
