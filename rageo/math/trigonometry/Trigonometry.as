package rageo.math.trigonometry 
{
	include "../index.as"
	
	public class Trigonometry 
	{
		public static var dx				: Number
		public static var dy				: Number
		public static var h					: Number
		public static var cos				: Number
		public static var sin				: Number
		public static var atan				: Number
		public static var radians			: Number
		public static var angle				: Number
		public static var face 				: String
		public static var spring			: Number
		public static var DEGREE_2RADIAN 	: Number = Math.PI / 180
		public static var RADIAN_2DEGREE	: Number = 180 / Math.PI

		public static function getAll ( pointA, pointB = null, y = "y", x = "x" )
		{
			getSinCos( pointA, pointB, y, x )	
			atan			=	dy/dx
			radians 		=	Math.atan(atan)
			radiansToAngle( radians, dx )
			return Trigonometry
		}

		public static function getSinCos(pointA, pointB, y = "y", x = "x")
		{
			hipotenusa( pointA, pointB, y, x )
			cos 			= 	MathUtil.forceNumber(dx/h)
			sin 			= 	MathUtil.forceNumber(dy/h)
			return Trigonometry
		}
		
		public static function distanceMouse( point, ref:DisplayObject )
		{
			dx 	= 	distance( point.x, ref.mouseX )
			dy 	= 	distance( point.y, ref.mouseY )
			return Math.sqrt(dx*dx+dy*dy)
		}

		public static function hipotenusa(pointA, pointB, y = "y", x = "x")
		{
			dx 	= 	distance(pointA[x], pointB[x])
			dy 	= 	distance(pointA[y], pointB[y])
			h	=	Math.sqrt(dx*dx+dy*dy)

			return Trigonometry
		}

		public static function distance(A, B)
		{
			return B-A
		}
		
		public static function radiansToAngle( radians, dx = 0)
		{
			angle	=	radians * RADIAN_2DEGREE + 90
			if( dx < 0 ) angle += 180
			return angle
		}

		public static function midPoint(A = 0, B = 0) 
		{
			return MathUtil.forceNumber(B + distance(A,B)/2)
		}

		public static function rotation2Degrees(ang)
		{
			ang = ang < 0 ? 360 + ang : ang	
			return ang
		}

		public static function getFace( trig:Object , diagonal:Number = .75, ISO:Boolean = false )
		{
			var cos = cos
			var sin = sin

			if ( cos > -diagonal && cos < diagonal ){
				face = ( sin < 0 ? "UP" : "DOWN")
			}else{
				face = ( cos < 0 ? "LEFT" : "RIGHT")
			}
			return Trigonometry
		}
		

		/*------------------------------------------------------------------------------------------------------------------
		
		
		
		
		ROTATION
		
		
		
		
		--------------------------------------------------------------------------------------------------------------------*/
		
		public static function aroundRadius( position:Number, radius:Number ) 
		{
			var rad 			= 	position * DEGREE_2RADIAN
			cos					=	Math.cos(rad)
			sin					=	Math.sin(rad)
			dx 					= 	radius * cos
			dy 					= 	radius * sin	
			radians 			=	Math.atan2( dy, dx )
			angle 				=	radiansToAngle( radians )
			
			return Trigonometry
		}
		
		
		/*------------------------------------------------------------------------------------------------------------------
		
		
		
		
		SPRING
		
		
		
		
		--------------------------------------------------------------------------------------------------------------------*/

		private static function applySpring (pointA, dist = 1, friction = 1, y = "y", x = "x")
		{
			spring			= 	(h-dist) / h
			pointA[x] 		+= 	dx * spring / friction
			pointA[y]		+= 	dy * spring / friction
		}

		public static function doSpring (pointA, pointB = null, dist = 1, friction = 1, y = "y", x = "x")
		{
			pointB ? hipotenusa(pointA, pointB, y, x) : null
			applySpring( pointA, dist, friction, y, x )
		}

		public static function springMin (pointA, pointB = null, dist = 1, friction = 1, y = "y", x = "x")
		{
			pointB ? hipotenusa(pointA, pointB, y, x) : null
			
			if (h < dist){
				applySpring( pointA,  dist, friction, y, x )
				return true
			}
			
			return false
		}

		public static function springMax (pointA, pointB = null, dist = 1, friction = 1, y = "y", x = "x")
		{
			pointB ? hipotenusa(pointA, pointB, y, x) : null

			if (h > dist){
				applySpring( pointA,  dist, friction, y, x )
				return true
			}
			
			return false
		}
		
		/*
		public static function springRange (pointA, pointB = null, min = 1, max = 10, friction = 1, y = "y", x = "x")
		{
			pointB ? hipotenusa(pointA, pointB, y, x) : null
			pointB = null
			
			var i 		=	springMin( pointA, pointB, min, trig, y ) 
			var m 		= 	springMax( pointA, pointB, max, trig, y )
			
			return i || m
		}*/

	}
}


	