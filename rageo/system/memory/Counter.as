
package rageo.system.memory
{
	include "../index.as"
	
	public final class Counter 
	{
		public static var keys 			: int = 0
		public static var dictionary 	: Dictionary = new Dictionary()
		
		public static function search( target:MovieClip ) 
		{
			var childs 		= 	SpriteUtil.getChilds( target )

			for ( var n in childs ) 
			{
				var item 	= 	childs[n]
				if ( item is MovieClip) 
				{
					var name = item.name.toLowerCase()
					if ( name.indexOf( "_text" ) != -1 || name.indexOf( "_bar" ) != -1 ) {
						new Counter ( item )
					}
				}
			}
		}
		
		public static function percent( key:String )
		{
			return dictionary[key].percent
		}

		public static function update( key:String, value ) 
		{
			dictionary[key].value = value
		}

		public static function increase( key:String,  value:Number=1 ) 
		{
			dictionary[key].increase(value)
		}
		
		public static function decrease( key:String, value:Number=1) 
		{
			dictionary[key].decrease(value)
		}
		
		public static function value( key:String ):Number
		{
			return dictionary[key].value
		}
		
		public static function reset( key:String=null ) 
		{
			if ( !key ) 
			{
				for(var n in dictionary){ dictionary[n].reset() }
				return
			}
			dictionary[key].reset()
		}
		
		public static function initialize( key:String, initialValue = 0, reachValue = null, onReach:Function = null, min = null, max = null )
		{
			var counter:Counter = dictionary[key]
			
			if ( !counter ) return
			
			counter.initialValue 		=	initialValue			
			counter.reachValue			=	reachValue
			counter.onReach				=	onReach
			counter.min 				=	min
			counter.max 				=	max
			counter.reset()
		}
		
		public static function extract( key:String, params ) 
		{
			ArrayUtil.extract( params, dictionary[key] )
		}
		
		public var bitmapText 			: BitmapText
		public var initialValue			: Number = 0
		public var reachValue 			
		public var onReach 				: Function
		public var _value 				: Number
		public var min 					
		public var max
		public var key 					: String
		public var target 				
		public var percent 				: int

		public function Counter( target, initialValue=0, reachValue=null, onReach:Function=null, min=null, max=null ) 
		{
			
			this.reachValue			=	reachValue
			this.onReach			=	onReach
			this.min 				=	min
			this.max 				=	max
			this.initialValue 		=	initialValue
			this.target 			=	target
			
			var name 				=	target.name.toLowerCase()
			var isText 				=	name.indexOf( "_text" ) != -1
			var key					=	name.split( isText ? "_text" : "_bar" )[0]
			var format				=	isText && String("time,score").indexOf( key ) != -1 ? key : format
			bitmapText				=	isText ? new BitmapText({ target:target, text:key, format:format }) : null

			this.key 				=	key || String( keys++ )

			dictionary[ this.key ]	=	this
			
			reset() 
		}
		
		public function update( val = null ) 
		{
			if ( val!=null )
			{
				_value 					=	val
				_value == reachValue && onReach != null ? onReach() : null
			}
			
			percent 					=	_value * 100/max
			bitmapText 					? 	bitmapText.play( { text:_value } ) : SpriteUtil.goPercent( target, _value * 100 / max, false )
			return _value
		}
		
		public function increase( amount:Number = 1 ) 
		{
			var val = Memory.plus( key, amount )
			val < min || val > max ?  val = Memory.setValue( key, MathUtil.constrain( val, min, max) ) : null
			return update( val )
		}
		
		public function decrease( amount:Number = 1 ) 
		{
			var val = MathUtil.constrain( Memory.getValue( key )-amount, min, max )
			return update( Memory.setValue( key, val ) )
		}
		
		public function get value() 
		{
			return update( Memory.getValue( key ) )
		}

		public function set value( amount ) 
		{
			return update( Memory.setValue( key, amount ) )
		}
		
		public function reset() 
		{
			return update( Memory.setValue( key, initialValue ) )
		}
		

	}

}

