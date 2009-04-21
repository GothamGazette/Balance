package rageo.math.particles 
{
	include "../index.as"
	
	public class Bounds 
	{

		public var radius			: uint
		public var top				: int
		public var bottom			: int
		public var left				: int
		public var right			: int
		public var width			: int
		public var height			: int
		public var back				: int
		public var front			: int
		public var x				: int
		public var y				: int

		public var hit : Boolean 

		public function Bounds ( top = 0, bottom = 0, left = 0, right = 0, back = 0, front = 0 )
		{
			this.top			=	top
			this.bottom			=	bottom
			this.left			=	left
			this.right			=	right
			this.back			=	back
			this.front			=	front
		}

		public function construct( params )
		{
			params is Rectangle || params is DisplayObject ? fromRectangle( params ) : ArrayUtil.extract( params, this )	
		}
		
		public function fromRectangle( rect ) 
		{
			top 			=	rect.y
			bottom 			=	rect.y + rect.height
			left 			=	rect.x 
			right 			=	rect.x + rect.width
		}

		public function reset()
		{
			top = bottom = left = right = back = front = radius = 0
		}

		public function constrain( target )
		{
			var hit : Boolean = false
			
			if( target.x < left ) 	target.x = left		, hit = true
			if( target.x > right ) 	target.x = right	, hit = true
			if( target.y < top ) 	target.y = top		, hit = true
			if( target.y > bottom ) target.y = bottom	, hit = true

			return hit
		}
		
		public function setAura( x, y, width, height)
		{
			var w 	= 	width / 2
			var h 	= 	height / 2
			
			left 	= 	x - w
			right 	= 	x + w
			top 	= 	y - h
			bottom 	= 	y + h
		}
		
		public function toString()
		{
			return "BOUNDS Left "+left+" Right "+right+" Top "+top+" Bottom "+bottom 
		}
		

		public function cropConstrain( target ) 
		{
			var w 	= 	target.width / 2
			var h 	= 	target.height / 2
			var hit : Boolean = false
			
			if( target.x - w > left ) 	target.x = left + w 	, hit = true
			if( target.x + w < right ) 	target.x = right - w 	, hit = true	
			if( target.y - h > top ) 	target.y = top + h 		, hit = true	
			if( target.y + h < bottom )	target.y = bottom - h 	, hit = true
			
			return hit
		}
		

	}
}


	