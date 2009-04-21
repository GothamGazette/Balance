/**
* ...
* @author Ariel Nehmad
* @version 0.1
*/

package gna.math 
{
	import gna.core.*
	import gna.utils.*
	
	public class Vector2 {
		
		public static const Zero:Vector2	 = new Vector2(0, 0)
		public static const Up:Vector2		 = new Vector2(0, 1)
		public static const Down:Vector2 	 = new Vector2(0, -1)
		public static const Right:Vector2 	 = new Vector2(1, 0)
		public static const Left:Vector2	 = new Vector2(-1, 0)
		
		private static var tx:Number
		private static var ty:Number
		
		public var x:Number
		public var y:Number
		
		public function Vector2( x:Number = 0, y:Number = 0 ) 
		{
			this.x = x
			this.y = y
		}
		
		public static function random():Vector2
		{
			var v:Vector2 = new Vector2( Math.random(), Math.random() )
				v.normalize()
				
			return v
		}
		
		static public function sub( v1:Vector2, v2:Vector2, out:Vector2 ):Vector2
		{
			out.x = v1.x - v2.x
			out.y = v1.y - v2.y
			return out
		}
		
		static public function add( v1:Vector2, v2:Vector2, out:Vector2 ):Vector2
		{
			out.x = v1.x + v2.x
			out.y = v1.y + v2.y
			return out
		}
		
		static public function adds( out:Vector2, ... args ):Vector2
		{
			for each(var v:Vector2 in args)
			{				
				out.x += v.x
				out.y += v.y
			}
			return out
		}
		
		static public function scale( v:Vector2, s:Number, out:Vector2 ):Vector2 
		{
			out.x = v.x * s
			out.y = v.y * s
			return out
		}
		
		static public function divide( v:Vector2, s:Number, out:Vector2 ):Vector2 
		{
			out.x = v.x / s
			out.y = v.y / s
			return out
		}
		
		static public function multiply( v1:Vector2, v2:Vector2, out:Vector2 ):Vector2 
		{
			out.x = v1.x * v2.x
			out.y = v1.y * v2.y
			return out
		}
		
		static public function cross( v:Vector2, out:Vector2 ):Vector2 
		{
			out.x = v.y
			out.y = -v.x
			return out
		}
		
		static public function dot( v1:Vector2, v2:Vector2 ):Number 
		{
			return v1.x * v2.x + v1.y * v2.y
		}
		
		static public function abs( v:Vector2, out:Vector2 ):Vector2 
		{
			out.x = Math.abs( v.x )
			out.y = Math.abs( v.y )
			return out
		}

		static public function negate( v:Vector2, out:Vector2 ):Vector2 
		{
			out.x = -v.x
			out.y = -v.y
			return out
		}
		
		static public function mirror( vec:Vector2, normal:Vector2, out:Vector2 ):Vector2
		{
			var dot:Number = Vector2.dot( vec, normal )
			
			out.x = vec.x - 2 * normal.x * dot
			out.y = vec.y - 2 * normal.y * dot
			out.normalize()
			
			return out
		}
		
		static public function distance( v1:Vector2, v2:Vector2 ):Number
		{
			tx = v1.x - v2.x
			ty = v1.y - v2.y
			return Math.sqrt( tx * tx + ty * ty )
		}
		
		static public function distance2( v1:Vector2, v2:Vector2 ):Number
		{
			tx = v1.x - v2.x
			ty = v1.y - v2.y
			return tx * tx + ty * ty
		}
		
		static public function pow( v:Vector2, pow:int )
		{
			v.x = Math.pow( v.x, pow )
			v.y = Math.pow( v.y, pow )
		}
		
		public function random( fromX:Number = 0, toX:Number = 0, fromY:Number = 0, toY:Number = 0 )
		{
			x = MathUtil.random( fromX, toX )
			y = MathUtil.random( fromY, toY )
		}
		
		public function set( x:Number = 0, y:Number = 0 ) 
		{
			this.x = x
			this.y = y
		}
		
		public function zero()
		{
			this.x = 0
			this.y = 0
		}
		
		public function sub( v:Vector2 ) 
		{
			x -= v.x
			y -= v.y
		}
		
		public function add( v:Vector2 ) 
		{
			x += v.x
			y += v.y
		}
		
		public function multiply( n:Vector2 )
		{
			x *= n.x
			y *= n.y
		}
		
		public function dot( v:Vector2 ):Number 
		{
			return x * v.x + y * v.y
		}
		
		public function scalar( v:Number ) 
		{
			x *= v
			y *= v
		}
		
		public function divide( v:Number ) 
		{
			x /= v
			y /= v
		}
		
		public function negate() 
		{
			this.x = -this.x
			this.y = -this.y
		}
		
		public function abs() 
		{
			this.x = Math.abs( x )
			this.y = Math.abs( y )
		}
		
		public function length():Number 
		{
			if ( x == 0 && y == 0 ) return 0
			return Math.sqrt( x * x + y * y )
		}
		
		public function length2():Number 
		{
			return x * x + y * y
		}
		
		public function normalize() 
		{
			var l:Number = Math.sqrt( x * x + y * y )
			if (l > 0) 
			{
				this.x /= l;
				this.y /= l;
			}
			else 
			{
				this.x = 0
				this.y = 0
			}
		}
		
		public function clone():Vector2 
		{
			return new Vector2( x, y )
		}
		
		public function fmax( v:Vector2 ) 
		{
			if (v.x > x) x = v.x
			if (v.y > y) y = v.y
		}
		
		public function fmin( v:Vector2 ) 
		{
			if (v.x < x) x = v.x
			if (v.y < y) y = v.y
		}
		
		public function equal( v:Vector2 ):Boolean 
		{
			if ( x == v.x && y == v.y ) return true
			return false
		}
		
		public function copy( v:Vector2 ) 
		{
			x = v.x
			y = v.y
		}
		
		private var toVec3:Vector3 = new Vector3()
		public function toVector3():Vector3
		{
			toVec3.set( x, y, 0 )
			return toVec3
		}
		
		public function transform( m:Matrix4 ) 
		{
			tx = this.x
			ty = this.y
			this.x = tx * m.m00 + ty * m.m10 + m.m30
			this.y = tx * m.m01 + ty * m.m11 + m.m31
		}
		
		public function transform3( m:Matrix4 ) 
		{
			tx = this.x
			ty = this.y
			this.x = tx * m.m00 + ty * m.m10
			this.y = tx * m.m01 + ty * m.m11
		}
		
		public function toString():String 
		{
			return "Vector2 x:" + x + ", y:" + y
		}		
	}	
}
