/*------------------------------------------------------------------------------------------------------------------



    POOL
	
	Copyright (C) 2008 http://www.cublo.com All Rights Reserved.
	
	
	
--------------------------------------------------------------------------------------------------------------------*/


package geeon.composite {

	include "../index.as"
	
	public class Pool {
	
		public var active 		: Array 
		public var inactive 	: Array
		public var classname	

		public function Pool( $classname )
		{
			active 				= 	[]
			inactive 			= 	[]
			classname 			= 	$classname
		}
	
		public function pull( params=null )
		{
		
			var item 	=	inactive.length ? inactive.shift() : new classname()
			params		?	item.construct( params ) : item.construct()
			active.push( item )
			return item 
			
		}

		public function push( obj:Class )
		{
			ArrayUtils.moveTo( obj, active, inactive )
		}
		
		public function call( func:String, params = null )
		{
			for (var n in active ){ params ? active[n][func]( params ) : active[n][func]() }
		}
		
		public function update()
		{
			for (var n in active ){ active[n].update() }
		}
		
		public function clear()
		{
			while (active.length){ inactive.push( active.shift() ) }
		}
		
		public function get length() {
			return active.length
		}

		
	}
	
}
