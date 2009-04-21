package rageo.util
{	
	include "../index.as"
	
	public class MathUtil 
	{		
		public static const DEG2RAD		: Number = 0.0174532925199433
		public static const RAD2DEG		: Number = 57.2957795130823
		public static const PHI			: Number = 1.61803398874989
		public static const LAMBDA		: Number = 0.57721566490143
		public static const RAD			: Number = Math.PI / 180
		public static const ANG			: Number = 180 / Math.PI
		public static const PI2			: Number = Math.PI * 2
		
		public static function random( from:Number, to:Number = 0 ):Number
		{
			return Math.random() * ( to - from ) + from
		}
		
		public static function randomInt( from:int, to:int = 0 ):int
		{
			return Math.random() * ( to - from + 1 ) + from
		}
		
		public static function randomSwitch( ...args )
		{
			var i:int = Math.random() * args.length
			
			return args[i]
		}
		
		public static function clamp( value:Number, min:Number, max:Number ):Number
		{
			if ( value > max ) value = max
			if ( value < min ) value = min
			return value
		}

		public static function randomArraySlot(arr:Array)
		{
			return arr[Math.floor(Math.random()*arr.length)]
		}
		
		public static function randomSign( value:Number )
		{
			return randomChance() ? value : -value
		}
		
		public static function randomMax(mx, min = 0)
		{
			return Math.round( Math.random() * ( mx -  min ) + min )
		}
		
		public static function randomOr ( a, b )
		{
			return randomArraySlot( [a,b] )
		}
		
		public static function randomSpectrum ( max = 1 )
		{
			return Math.random() * max * 2 - max
		}

		public static function randomChance ( c:Number = .5 )
		{
			return Math.random() > c 
		}
		
		public static function sgn( value:Number ):Number
		{
			return value > 0 ? 1 : -1
		}
		
		public static function toHex( n:int, bigEndian:Boolean = false ):String 
		{
			var hexChars:String = "0123456789abcdef";
			var s:String = "";
			
			if ( bigEndian ) {
				for ( var i:int = 0; i < 4; i++ ) {
					s += hexChars.charAt( ( n >> ( ( 3 - i ) * 8 + 4 ) ) & 0xF ) 
						+ hexChars.charAt( ( n >> ( ( 3 - i ) * 8 ) ) & 0xF );
				}
			} else {
				for ( var x:int = 0; x < 4; x++ ) {
					s += hexChars.charAt( ( n >> ( x * 8 + 4 ) ) & 0xF )
						+ hexChars.charAt( ( n >> ( x * 8 ) ) & 0xF );
				}
			}
			
			return s;
		}
		
		public static function ln(n:Number):Number
		{
			return (Math.log(n));
		}

		public static function logA(a:Number,n:Number):Number
		{
			return (Math.log(n)/Math.log(a));
		}

		public static function summation(n:Number,x:Number):Number
		{
			var sum:Number = 0;
			var j:Number;

			for (j=1;j<=n;j++) sum += Math.pow(j,x);

			return sum;
		}

		public static function square(n:Number):Number
		{
			return n*n;
		}

		public static function inverse(n:Number):Number
		{
			return 1/n;
		}

		public static function pow2(a:Number,n:Number):Number
		{
			return a==0 ? 0 : (a>0 ? Math.pow(a,n) : Math.pow(a*-1,n)*-1);
		}

		public static function nRoot(a:Number,n:Number):Number
		{
			return pow2(a,1/n);
		}

		public static function factorial(n:Number):Number
		{
			if (n!=0)
			{
				return n*factorial(n-1);
			}
			else
			{
				return (1);
			}
		}

		public static function gammaApprox(n:Number):Number
		{
			var x:Number = n-1;

			return (Math.sqrt((2*x+1/3)*Math.PI)*Math.pow(x,x)*Math.exp(-x));
		}

		public static function factorialApprox(n:Number):Number
		{
			return (Math.round(gammaApprox(n+1)));
		}

		public static function productFactors(n:Number):Number
		{
			var k:Number = 1;
			var h:Number;

			for (h=3;h<=n;h+=2) if (isPrime(h)) k *= h;
			if (n>2) k *= 2;

			return k;
		}

		public static function fibonacci(n:Number):Number
		{
			return Math.round((Math.pow((1+Math.sqrt(5))/2,n)-Math.pow((1-Math.sqrt(5))/2,n))/Math.sqrt(5));
		}

		public static function isPrime(n:Number):Boolean
		{
			var h:Number;

			n |= 0;
			if (isNaN(n) || n==0) return false;
			if (n<=3) return true;
			if (n%2==0) return false;

			var iMax:Number = Math.floor(Math.sqrt(n));

			for (h=3;h<=iMax;h+=2) if (n%h==0) return false;
			return true
		}

		public static function isPrime2(n:Number)
		{
			n |= 0;
			if (isNaN(n) || n==0) return false;
			if (n<=3) return true;
			if (n%2==0) return false;

			var iMax:Number = (Math.sqrt(n)/6 | 0)*6+5;
			var j:Number = 5;

			while (n%j!=0 && n%(j+2)!=0 && (j+=6)!=iMax) {}

			return (j==iMax);
		} 

		public static function findPrimeFrom(n:Number,from:Number):Array
		{
			n |= 0;
			from |= 0;

			var i,j:Number;
			var output_arr:Array = [];
			var count_arr:Array = [];

			if (!from) from = 0;
			else from -= 1;
			n += 1;
			for (i=0;i<n;i++) count_arr[i] = 0;

			var sqrtN:Number = Math.round(Math.sqrt(n+1));
			var last:Number = 2;

			for (i=2;i<=sqrtN;i++)
			{
				if (count_arr[i]==0)
				{
					for (j=last*i;j<n;j+=i) count_arr[j] = 1;
					last = i;
				}
			}
			for (i=n-1;i>from;i--)
			{
				if (count_arr[i] == 0) output_arr.push(i);
			}

			return output_arr;
		}

		public static function totient(n:Number):Number
		{
			var k:Number = 1;
			var j:Number;

			if (n%2==0) j++;
			for (j=3;j<=n;j+=2) if (isPrime(j)) k++;

			return k;
		}

		public static function positive(e)
		{
			return e > 0 ? e : -e
		}
		
		public static function negative(e)
		{
			return e < 0 ? e : -e
		}
		
		public static function distance( x1:Number, x2:Number, y1:Number, y2:Number ) 
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt( dx * dx + dy * dy );
		}
		
		public static function cycle(e:Number = 0, min:int = 0, max:int = 100,  inc:Number = 1, loop:Boolean = true) 
		{
			var dist:int = max - min + 1
			e += inc
			if ( !loop ) return clamp( e, min, max )
			while ( e > max ) e -= dist
			while ( e < min ) e += dist
			return e
		}
		
		public static function sign(e, unit = false)
		{
			return e > 0 ? ( unit ? 1 : true ) : ( unit ? -1 : false )
		}

		public static function constrain(e:Number, min = null, max = null, decimals:Boolean = true) 
		{
			var e = e
			min != null && e < min ? e = min : null
			max != null && e > max ? e = max : null

			return decimals ? e : Math.round(e);
		}
		
		public static function getPercent( input, compare = 100, max = 100, min = 0, margin = 0, decimals = true ) 
		{
			return constrain((input-margin)*max/(compare-margin*2), min, max, decimals);
		}
		
		public static function forceNumber(num) 
		{
			return isNumber(num) ? Number(num) : 0;
		}

		public static function isNumber(num) 
		{
			return String(Number(num)) != "NaN" ? true : false;
		}
	}
	
}