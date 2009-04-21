package rageo.util
{	
	include "../index.as"
	
	public class ArrayUtil 
	{		
		
		public static function contains(a:Array, item:*):Boolean
		{
			return (a.indexOf(item) != -1);
		}	
		
		public static function del( a:Array, item:*):*
		{
			a.splice( a.indexOf( item ), 1 )
			return item
		}
		
		public static function random( a:Array )
		{
			a.sort(shuffle);
		}

		private static function shuffle( a, b ):int
		{
			return Math.round(Math.random()*2)-1;
		}

		public static function extract(from, to) 
		{
			for (var n in from) {
				to[n]=from[n]
			}
			return to
		}

		public static function length(obj){
			
			if (obj is Array) {
				return obj.length
			}

			var l= 0
			for (var n in obj) {
				l++
			}
			
			return l
		}

		public static function getItemByProperty( arr:Array, property:String, value:Object) 
		{
			for (var n in arr) {
				if ( arr[n][property] && arr[n][property] == value ) { return arr[n] }
			}
			return false
		}
		
		public static function search( arr:Array, property:String, value:Object) 
		{
			var results : Array = []
			for (var n in arr) {
				if ( !(arr[n] is String) && arr[n][property] == value ) { results.push( arr[n] ) }
			}
			
			Debug.print( results , "SEARCH RESULTS" )
			return results
		}
		
		public static function arrayContainsValue(arr:Array, value:Object)
		{
			return (arr.indexOf(value) != -1);
		}	
		
		public static function randomItem( object ) {
			
			var arr 	=	[]
			for (var n in object) {arr.push( object[n] )}
			return random( arr )
			
		}
		
		public static function containsItem(value, arr)
		{
			return (arr.indexOf(value) != -1);
		}	

		public static function removeValueFromArray(arr:Array, value:Object)
		{
			var len:uint = arr.length;
			
			for(var i:Number = len; i > -1; i--){
				if(arr[i] === value)
				{
					arr.splice(i, 1);
				}
			}					
		}

		public static function createUniqueCopy(a:Array):Array
		{
			var o:Object 		= 	new Object()
			var newArray:Array 	= 	new Array()
			var len:Number 		= 	a.length
			var item:Object
			
			for (var i:uint = 0; i < len; ++i)
			{
				item = a[i]
				if(arrayContainsValue(newArray, item))
				{
					continue
				}
				
				newArray.push(item)
			}
			
			return newArray
		}

		public static function copy(arr:Array, amount=null):Array
		{	
			var output 	: Array =  []
			var amount 	 = amount !=null ? amount : arr.length
			var n 		: int = 0
			while( n < amount)
			{ 
				output.push(arr[n]) 
				n++
			}
			return output
		}

		public static function copyRows(arr:Array):Array
		{	
			return arr.slice()
		}

		public static function sort( array, property = "y", descending = true ) 
		{
			descending 		? 	array.sortOn( property, Array.DESCENDING | Array.NUMERIC ) : array.sortOn( property )
			return array
		}

		public static function extractToNew( obj ):Array 
		{	
			var obj2 = []
			extract( obj, obj2 )
			return obj2
		}

		public static function areEqual(arr1:Array, arr2:Array):Boolean
		{
			if(arr1.length != arr2.length)
			{
				return false
			}
			
			var len:Number = arr1.length
			for(var i:Number = 0; i < len; i++)
			{
				if(arr1[i] !== arr2[i])
				{
					return false
				}
			}
			
			return true
		}
		
		public static function clone(source:Object):* 
		{
			var copier:ByteArray = new ByteArray();
			copier.writeObject( source );
			copier.position = 0;
			return(copier.readObject());
		}

		public static function next( array ) 
		{
			return cycle( array, 1 )
		}
		
		public static function previous( array ) 
		{
			return cycle( array, -1 )
		}
		
		public static function cycle( array, inc = 1 ) 
		{
			array._position 			=	MathUtil.cycle( array._position, 0, array.length-1,  inc ) 
			return array[ array._position ]
		}
		
		public static function moveTo( object, array, toArray ) 
		{
			removeItem( object, array )
			toArray.push( object )
		}
		
		public static function removeItem( object, array ) 
		{
			array.splice( array.indexOf( object ), 1 )
		}

		public static function sumProperties( arrayList ) 
		{
			var output = []
			for (var n in arrayList) { sumExtract( arrayList[n], output )}
			return output
		}

		public static function sumExtract( array, toArray ) 
		{
			for ( var n in array) {
				toArray[n] = toArray[n] ? Number(array[n]) + Number(toArray[n]): Number(array[n])
			}
		}
		
		public static function suffle( arr, amount = null ) 
		{
			var amount 	= 	amount || arr.length
			var dupe 	= 	copy( arr )
			var output	= 	new Array()

			while ( output.length < amount ) {
				output.push( dupe.splice( MathUtil.randomMax( dupe.length-1 ), 1 )[0] )
			}
			return output
		}
		
		public static function getRandom( array ) 
		{
			return array[ Math.round(MathUtil.random(array.length-1)) ]
		}
		
		public static function remove( item, array  ) 
		{
			array.splice( array.indexOf( item ), 1 ) 
			return array
		}
		
		public static function toInverse( array ) 
		{
			var object 			=	{}
			for ( var n in array ) { 
				object[ String(array[n]) ] = n 
			}
			return object
		}
		
		public static function getConfig( array, nodeName, id=null ) 
		{
			return id ? getItemByProperty( array[nodeName], "id", id)  : array[nodeName]
		}
		
		public static function parseCommas( node=null ) 
		{
			if( !node ) return []
			
			if (node is Array ) 
			{
				if ( node.default && node.value) {
					var temp:Array = []
					for ( var i:int = 0; i < node.length; i++ ) {
						temp.push( ArrayUtil.extract( node[i], ArrayUtil.copy( node.default )))
					}
					node = temp
				}

				if ( node.value ) 
				{
					var value = node.value
					if (value is String && value.indexOf(",") !=-1) node.value = node.value.split(",")
				}
				for (var n in node) 
				{ 
					if ( n != "text" ) node[n] = parseCommas( node[n] )
				}
			} else if ( node is String && node.indexOf(",") != -1)
			{
				node = node.split(",")
			}
			
			return node
		}
		
		public static function getItem( linkage, array:Array, key:String="id" )
		{ 
			if ( linkage is String ) 
			{
				return getItemByProperty( array, key, linkage )
			}
			
			var output 
			var passed : Boolean = false
			do 
			{
				output 	=	getRandom( array ) 
				passed 	=	true
				
				if ( output.probability != null ) {
					passed 	= MathUtil.randomChance( output.probability/100 )
				}
				
			}
			while( !passed )
			
			return output
		}
		
		public static function getProbableItem( array:Array )
		{ 
			var output : Object
			var passed : Boolean = false
			do 
			{
				output 	=	getRandom( array ) 
				passed 	=	true
				if ( output.probability != null ) passed = MathUtil.randomChance( output.probability/100 )
			}
			
			while( !passed )
			
			return output
		}
		
	}
	
}