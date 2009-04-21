/**
* ...
* @author Ariel Nehmad
* @version 0.1
*/

package gna.math 
{
	import gna.core.*
	import gna.utils.*
	
	public class Vector3 {
		
		public static const Zero:Vector3 = new Vector3(0, 0, 0)
		public static const Up:Vector3 = new Vector3(0, 1, 0)
		public static const Down:Vector3 = new Vector3(0, -1, 0)
		public static const Right:Vector3 = new Vector3(1, 0, 0)
		public static const Left:Vector3 = new Vector3(-1, 0, 0)
		public static const Forward:Vector3 = new Vector3(0, 0, 1)
		public static const Backward:Vector3 = new Vector3(0, 0, -1)
		
		private static var tx:Number
		private static var ty:Number
		private static var tz:Number
		
		public var x:Number
		public var y:Number
		public var z:Number
		
		public function Vector3(x:Number = 0, y:Number = 0, z:Number = 0) 
		{
			this.x = x
			this.y = y
			this.z = z
		}
		
		public static function random( out:Vector3 ):Vector3
		{
			out.x = Math.random() - 0.5
			out.y = Math.random() - 0.5
			out.z = Math.random() - 0.5
			out.normalize()			
			return out
		}
		
		static public function sub(v1:Vector3, v2:Vector3, out:Vector3):Vector3
		{
			out.x = v1.x - v2.x
			out.y = v1.y - v2.y
			out.z = v1.z - v2.z
			return out
		}
		
		static public function add(v1:Vector3, v2:Vector3, out:Vector3):Vector3
		{
			out.x = v1.x + v2.x
			out.y = v1.y + v2.y
			out.z = v1.z + v2.z
			return out
		}
		
		static public function adds(out:Vector3, ... args):Vector3
		{
			for each(var v:Vector3 in args)
			{				
				out.x += v.x
				out.y += v.y
				out.z += v.z
			}
			return out
		}
		
		static public function scale(v:Vector3, s:Number, out:Vector3):Vector3 
		{
			out.x = v.x * s
			out.y = v.y * s
			out.z = v.z * s
			return out
		}
		
		static public function divide(v:Vector3, s:Number, out:Vector3):Vector3 
		{
			out.x = v.x / s
			out.y = v.y / s
			out.z = v.z / s
			return out
		}
		
		static public function multiply(v1:Vector3, v2:Vector3, out:Vector3):Vector3 
		{
			out.x = v1.x * v2.x
			out.y = v1.y * v2.y
			out.z = v1.z * v2.z
			return out
		}
		
		static public function cross(v1:Vector3, v2:Vector3, out:Vector3):Vector3 
		{
			out.x = v1.y * v2.z - v1.z * v2.y
			out.y = v1.z * v2.x - v1.x * v2.z
			out.z = v1.x * v2.y - v1.y * v2.x
			return out
		}
		
		static public function dot(v1:Vector3, v2:Vector3):Number 
		{
			return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
		}
		
		static public function abs(v:Vector3, out:Vector3):Vector3 
		{
			out.x = Math.abs(v.x)
			out.y = Math.abs(v.y)
			out.z = Math.abs(v.z)
			return out
		}

		static public function negate(v:Vector3, out:Vector3):Vector3 
		{
			out.x = -v.x
			out.y = -v.y
			out.z = -v.z
			return out
		}
		
		static public function mirror(vec:Vector3, normal:Vector3, out:Vector3):Vector3
		{
			var dot:Number = Vector3.dot(vec, normal)
			
			out.x = vec.x - 2 * normal.x * dot
			out.y = vec.y - 2 * normal.y * dot
			out.z = vec.z - 2 * normal.z * dot
			out.normalize()
			
			return out
		}
		
		static public function distance(v1:Vector3, v2:Vector3):Number
		{
			tx = v1.x - v2.x
			ty = v1.y - v2.y
			tz = v1.z - v2.z
			return Math.sqrt( tx * tx + ty * ty + tz * tz )
		}
		
		static public function distance2(v1:Vector3, v2:Vector3):Number
		{
			tx = v1.x - v2.x
			ty = v1.y - v2.y
			tz = v1.z - v2.z
			return tx * tx + ty * ty + tz * tz
		}
		
		static public function distanceX( v1:Vector3, v2:Vector3 ):Number
		{
			return v1.x - v2.x
		}
		
		static public function distanceY( v1:Vector3, v2:Vector3 ):Number
		{
			return v1.y - v2.y
		}
		
		static public function distanceZ( v1:Vector3, v2:Vector3 ):Number
		{
			return v1.z - v2.z
		}
		
		static public function pow(v:Vector3, pow:int)
		{
			v.x = Math.pow(v.x, pow)
			v.y = Math.pow(v.y, pow)
			v.z = Math.pow(v.z, pow)
		}
		
		static public function min( out:Vector3, ...args )
		{
			out.x = Number.MAX_VALUE
			out.y = Number.MAX_VALUE
			out.z = Number.MAX_VALUE
			for each ( var v:Vector3 in args )
			{
				if ( v.x < out.x ) out.x = v.x
				if ( v.y < out.y ) out.y = v.y
				if ( v.z < out.z ) out.z = v.z
			}
		}
		
		static public function max( out:Vector3, ...args )
		{
			out.x = Number.MIN_VALUE
			out.y = Number.MIN_VALUE
			out.z = Number.MIN_VALUE
			for each ( var v:Vector3 in args )
			{
				if ( v.x > out.x ) out.x = v.x
				if ( v.y > out.y ) out.y = v.y
				if ( v.z > out.z ) out.z = v.z
			}
		}
		
		static public function smooth( src:Vector3, dest:Vector3, smoothValue:Number )
		{
			src.x += ( dest.x - src.x ) * smoothValue
			src.y += ( dest.y - src.y ) * smoothValue
			src.z += ( dest.z - src.z ) * smoothValue
		}
		
		static public function equal( v0:Vector3, v1:Vector3 ):Boolean 
		{
			if ( v0.x == v1.x && v0.y == v1.y && v0.z == v1.z) return true
			return false
		}
		
		public function random(fromX:Number = 0, toX:Number = 0, fromY:Number = 0, toY:Number = 0, fromZ:Number = 0, toZ:Number = 0)
		{
			x = MathUtil.random( fromX, toX )
			y = MathUtil.random( fromY, toY )
			z = MathUtil.random( fromZ, toZ )
		}
		
		public function round()
		{
			x = Math.round( x )
			y = Math.round( y )
			z = Math.round( z )
		}
		
		public function set(x:Number = 0, y:Number = 0, z:Number = 0) 
		{
			this.x = x
			this.y = y
			this.z = z
		}
		
		public function zero()
		{
			this.x = 0
			this.y = 0
			this.z = 0
		}
		
		public function sub(v:Vector3) 
		{
			x -= v.x
			y -= v.y
			z -= v.z
		}
		
		public function add(v:Vector3) 
		{
			x += v.x
			y += v.y
			z += v.z
		}
		
		public function multiply( n:Vector3 )
		{
			x *= n.x
			y *= n.y
			z *= n.z
		}
		
		public function dot(v:Vector3):Number 
		{
			return x * v.x + y * v.y + z * v.z
		}
		
		public function scalar(v:Number) 
		{
			x *= v
			y *= v
			z *= v
		}
		
		public function divide(v:Number) 
		{
			x /= v
			y /= v
			z /= v
		}
		
		public function negate() 
		{
			this.x = -this.x
			this.y = -this.y
			this.z = -this.z
		}
		
		public function abs() 
		{
			this.x = Math.abs(x)
			this.y = Math.abs(y)
			this.z = Math.abs(z)
		}
		
		public function length():Number 
		{
			if (x == 0 && y == 0 && z == 0) return 0
			return Math.sqrt( x * x + y * y + z * z )
		}
		
		public function length2():Number 
		{
			return x * x + y * y + z * z
		}
		
		public function normalize() 
		{
			var l:Number = Math.sqrt( x * x + y * y + z * z )
			if (l > 0) 
			{
				this.x /= l;
				this.y /= l;
				this.z /= l;
			}
			else 
			{
				this.x = 0
				this.y = 0
				this.z = 0
			}
		}
		
		public function clone():Vector3 
		{
			return new Vector3( x, y, z )
		}
		
		public function fmax( v:Vector3 ) 
		{
			if ( v.x > x ) x = v.x
			if ( v.y > y ) y = v.y
			if ( v.z > z ) z = v.z
		}
		
		public function fmin( v:Vector3 )
		{
			if ( v.x < x ) x = v.x
			if ( v.y < y ) y = v.y
			if ( v.z < z ) z = v.z
		}
		
		public function equal( v:Vector3 ):Boolean 
		{
			if ( x == v.x && y == v.y && z == v.z ) return true
			return false
		}
		
		public function copy( v:Vector3 ) 
		{
			x = v.x
			y = v.y
			z = v.z
		}
		
		public function transform( m:Matrix4 ) 
		{
			tx = this.x
			ty = this.y
			tz = this.z
			this.x = tx * m.m00 + ty * m.m10 + tz * m.m20 + m.m30
			this.y = tx * m.m01 + ty * m.m11 + tz * m.m21 + m.m31
			this.z = tx * m.m02 + ty * m.m12 + tz * m.m22 + m.m32
		}
		
		public function transform3( m:Matrix4 ) 
		{
			tx = this.x
			ty = this.y
			tz = this.z
			this.x = tx * m.m00 + ty * m.m10 + tz * m.m20
			this.y = tx * m.m01 + ty * m.m11 + tz * m.m21
			this.z = tx * m.m02 + ty * m.m12 + tz * m.m22
		}
		
		public function position( x:Number = 0, y:Number = 0, z:Number = 0, m:Matrix4 = null ) 
		{
			if ( !m ) 
			{
				this.x = x
				this.y = y
				this.z = z
			}
			else 
			{
				this.x = x * m.m00 + y * m.m10 + z * m.m20 + m.m30
				this.y = x * m.m01 + y * m.m11 + z * m.m21 + m.m31
				this.z = x * m.m02 + y * m.m12 + z * m.m22 + m.m32
			}
		}
		
		public function toVertex():Vertex 
		{
			return new Vertex(x, y, z)
		}
		
		public function toVector2():Vector2
		{
			return new Vector2( x, y )
		}
		
		public function toString():String 
		{
			return "Vector3 x:" + x + ", y:" + y + ", z:" + z
		}		
	}	
}
