
package rageo.system.memory 
{
	include "../index.as"
	
	public final class Memory 
	{
		static var KEY					: String = 	String(Math.random()).substr( 2, 14 ) + String(Math.random()).substr( 2, 14 )
		static var list					: Array = []
		static var initialized			: Boolean = false
		
		public static var global		: Object = { }
		public static var config 		: Array
		public static var dictionary 	: Dictionary = new Dictionary()
		
		public static function extract( data ) 
		{
			ArrayUtil.extract( data, global )
		}

		public static function getValue( name:String ) 
		{
			var name = Encryption.encrypt( name, KEY )
			return list[name] != null ? Encryption.decrypt(list[name], KEY) : ""
		}
		
		public static function setValue( name:String, value ) 
		{
			list[Encryption.encrypt(name, KEY)] = Encryption.encrypt( value.toString(), KEY )
			return value
		}
		
		public static function plus( name:String, amount:Number=1 )
		{
			var value 							= 	MathUtil.forceNumber( getValue(name) )
			value 								+= 	amount
			list[Encryption.encrypt(name, KEY)] = 	Encryption.encrypt(value.toString(), KEY)
			return value
		}

		public static function multiply( name:String, amount:Number )
		{
			var value 	=  	MathUtil.forceNumber( getValue(name) )
			value 		*= 	amount
			
			return setValue( name, value )
		}

	}

}

