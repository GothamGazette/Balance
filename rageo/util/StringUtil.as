package rageo.util
{	
	include "../index.as"
	
	public class StringUtil 
	{		
		public static function trim(str:String):String 
		{			
			str = String(str)
			while (str.charAt(0) == " ") str = str.substr(1)
			while (str.charAt(str.length - 1) == " ") str = str.substr(0, -1)
			return str
		}

		public static function lTrim(str:String):String 
		{			
			str = String(str)
			while (str.charAt(0) == " ") str = str.substr(1)
			return str
		}

		public static function rTrim(str:String):String 
		{			
			str = String(str)
			while (str.charAt(str.length - 1) == " ") str = str.substr(0, -1)
			return str
		}
		
		public static function string(char:String, repeat:int):String 
		{
			if (repeat <= 0) return ""
			var r:String = ""
			for (var i:uint = 0; i < repeat; i++) r += char
			return r
		}
		
		public static function lFill(string:String, char:String, len:uint):String 
		{
			while(string.length < len) string = char + string
			return string
		}		
		
		public static function rFill(string:String, char:String, len:uint):String 
		{
			while(string.length < len) string = string + char
			return string
		}
		
		public static function getTimeString(millisecs:int, separator:String = "."):String 
		{
			var iSec:int = millisecs / 1000
			var iCent:int = (millisecs - iSec * 1000) / 10			
			var sec:String = StringUtil.lFill(String(iSec), "0", 2)
			var cent:String = StringUtil.lFill(String(iCent), "0", 2)			
			return sec + separator + cent	
		}
		
		public static function getFormatTime( millisecs:int, showMillisecs:Boolean = true ):String
		{
			var time:Number = millisecs / 1000
			var tMin:int = time / 60
			var tSec:int = time - tMin * 60
			var tMil:int = millisecs - tMin * 60000 - tSec * 1000
			var format:String = ""			
			format += lFill( tMin.toString(), "0", 2 ) + ":"			
			format += lFill( tSec.toString(), "0", 2 )
			if ( showMillisecs ) format += "." + lFill( tMil.toString().substr( 0, 2 ), "0", 2 )
			return format
		}
		
		public static function validateEmail( email:String ):Boolean
		{
			var EMAIL_REGEX:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i
			
			return Boolean(email.match(EMAIL_REGEX));
		}
		
		public static function beginsWith(input:String, prefix:String):Boolean
		{			
			return (prefix == input.substring(0, prefix.length));
		}	

		public static function endsWith(input:String, suffix:String):Boolean
		{
			return (suffix == input.substring(input.length - suffix.length));
		}	

		public static function replaceStr(input:String, replace:String, replaceWith:String):String
		{
			var sb:String = new String();
			var found:Boolean = false;

			var sLen:Number = input.length;
			var rLen:Number = replace.length;

			for (var i:Number = 0; i < sLen; i++)
			{
				if(input.charAt(i) == replace.charAt(0))
				{   
					found = true;
					for(var j:Number = 0; j < rLen; j++)
					{
						if(!(input.charAt(i + j) == replace.charAt(j)))
						{
							found = false;
							break;
						}
					}

					if(found)
					{
						sb += replaceWith;
						i = i + (rLen - 1);
						continue;
					}
				}
				sb += input.charAt(i);
			}
			return sb;
		}

		public static function getFileExtension(target:String) 
		{
			return target.substring(target.lastIndexOf(".")+1, target.length).toLowerCase();
		}

		public static function strReplace(search, replace, str) 
		{
			var string = String(str);
			return string.split(search).join(replace);
		}

		public static function excludeChars(target:String, chars:String=":,<>-'{}[]/*-+!;8!@#$%.^&*()") 
		{
			var txt = "", valid;
			for (var c = 0; c<target.length; c++) {
				valid = true;
				for (var z = 0; z<chars.length; z++) {
					if (target.charAt(c) == chars.charAt(z)) {
						valid = false;
						break;
					}
				}
				valid ? txt += target.charAt(c):null
			}
			return txt;
		}

		public static function seconds2Minutes(num) 
		{
			var m = 0;
			while (num>60) {
				num -= 60
				m++
			}
			return fillZero(m)+":"+fillZero(Math.round(num));
		}

		public static function fillZero(input, zeros = 1) 
		{
			var string 	= 	String(input)
			while (string.length < zeros+1){
				string = "0"+string
			}
			return string
		}

		public static function commas(num, interval = 3) 
		{
			var num = String(num)
			var output = ""
			var str
			var c = 0;
			
			for (var n = num.length-1; n>=0; n--) {
				 str = "";
				(++c >= interval && n>0) ? (c=0, str=",") : null;
				str += num.charAt(n);
				output = str+output;
			}
			
			return output;
		}
		
		public static function toDollars( value:Number, sign:String="$", divider:int=1 ) 
		{
			var isNeg 		: Boolean	= value < 0
			var formatted 	: String	= sign + commas( Math.abs( Math.round( value/divider ) ) )
			if( isNeg ) formatted 		= "-" + formatted
			return formatted
		}
		
		public static function charsToLongs(chars:Array):Array 
		{
			var temp:Array = new Array(Math.ceil(chars.length/4));
			for (var i:Number = 0; i<temp.length; i++) {
				temp[i] = chars[i*4] + (chars[i*4+1]<<8) + (chars[i*4+2]<<16) + (chars[i*4+3]<<24);
			}
			return temp;
		}
		
		public static function longsToChars(longs:Array):Array 
		{
			var codes:Array = new Array();
			for (var i:Number = 0; i<longs.length; i++) {
				codes.push(longs[i] & 0xFF, longs[i]>>>8 & 0xFF, longs[i]>>>16 & 0xFF, longs[i]>>>24 & 0xFF);
			}
			return codes;
		}

		public static function charsToHex(chars:Array):String
		{
			var result:String = new String("");
			var hexes:Array = new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");
			for (var i:Number = 0; i<chars.length; i++) {
				result += hexes[chars[i] >> 4] + hexes[chars[i] & 0xf];
			}
			return result;
		}

		public static function hexToChars(hex:String):Array 
		{
			var codes:Array = new Array();
			for (var i:Number = (hex.substr(0, 2) == "0x") ? 2 : 0; i<hex.length; i+=2) {
				codes.push(parseInt(hex.substr(i, 2), 16));
			}
			return codes;	
		}
		
		public static function charsToStr(chars:Array):String 
		{
			var result:String = new String("");
			for (var i:Number = 0; i<chars.length; i++) {
				result += String.fromCharCode(chars[i]);
			}
			return result;
		}

		public static function strToChars(str:String):Array 
		{
			var codes:Array = new Array();
			for (var i:Number = 0; i<str.length; i++) {
				codes.push(str.charCodeAt(i));
			}
			return codes;
		}
		
		public static function extractKeywords( text:String, length:int=2 ):Array
		{
			var validChars	:	String = "abcdefghijklmnopqrstuvwxyz"
			var output		: 	Array = []
			var max 		: 	int = text.length
			var text 		: 	String = text.toLowerCase()
			var string 		: 	String = ""
			
			for( var n:int = 0; n< max; n++ )
			{
				var char 	=	text.charAt( n )
				
				if( validChars.indexOf( char ) != -1 )
				{
					string += char
				}else{
					
					if( string.length > length ) output.push( string )
					string = ""
				}
			}
			
			return output
		}
		
		public static function toString( target, brakeCount = 0 )
		{
			var type 			= 	typeof(target)
			var output			=	""
			brakeCount			+=	1
			var brake 			= 	"\n"

			for (var n = 0 ; n< brakeCount ; n++) {
				brake += "\t"
			}
			
			//
			
			if (type=="string" || type=="number" || type=="boolean") {
				type=="string" ? output += '"' : null
				output += String(target) 
				type=="string" ? output += '"' : null
			}
			
			if (type=="object") {
				
				output += target is Array ? "[" : "{"
	
				for (var i in target) {
					output += brake + String(i) + " : "  + toString(target[i], brakeCount )
				}
				
				output += brake
				output += target is Array ? "]" : "}"
			}
			
			if (type=="movieclip") {
				output += "(movieclip) "+String(target) 
			}
			
			if (type=="function") {
				output += "(function) "+String(target) 
			}

			return output
		}
		
		public static function toPHPArray( object:Object ) 
		{
			var output	= 'array('
			for ( var n in object) output += '"'+ n +'" => "'+ object[n] +'";'
			output = output.substr( 0,output.length-1) + ')'
			return output
		}
		
		
	}
}