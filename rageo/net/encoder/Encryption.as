package rageo.net.encoder 
{
	include "../index.as"
	
	public class Encryption {

		// ENCRYPT
		public static function encrypt(src:String, key:String):String {
			var v:Array = StringUtil.charsToLongs(StringUtil.strToChars(src));
			var k:Array = StringUtil.charsToLongs(StringUtil.strToChars(key));
			var n:Number = v.length;
			if (n == 0) return "";
			if (n == 1) v[n++] = 0;
			var z:Number = v[n-1], y:Number = v[0], delta:Number = 0x9E3779B9;
			var mx:Number, e:Number, q:Number = Math.floor(6+52/n), sum:Number = 0;
			while (q-- > 0) {
				sum += delta;
				e = sum>>>2 & 3;
				for (var p:Number = 0; p<n-1; p++) {
					y = v[p+1];
					mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
					z = v[p] += mx;
				}
				y = v[0];
				mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
				z = v[n-1] += mx;
			}
			return StringUtil.charsToHex(StringUtil.longsToChars(v));
		}

		// DECRYPT
		public static function decrypt(src:String, key:String):String {
			var v:Array = StringUtil.charsToLongs(StringUtil.hexToChars(src));
			var k:Array = StringUtil.charsToLongs(StringUtil.strToChars(key));
			var n:Number = v.length;
			if (n == 0) return "";
			var z:Number = v[n-1], y:Number = v[0], delta:Number = 0x9E3779B9;
			var mx:Number, e:Number, q:Number = Math.floor(6 + 52/n), sum:Number = q*delta;
			while (sum != 0) {
				e = sum>>>2 & 3;
				for(var p:Number = n-1; p > 0; p--){
					z = v[p-1];
					mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
					y = v[p] -= mx;
				}
				z = v[n-1];
				mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
				y = v[0] -= mx;
				sum -= delta;
			}
			return StringUtil.charsToStr(StringUtil.longsToChars(v));
		}
		
	}
}