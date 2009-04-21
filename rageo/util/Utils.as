package rageo.util
{	
	include "../index.as"

	public class Utils {
		
		public static function getURL (url:String, window:String = "_blank") 
		{
			var myurl = url || "url"
			navigateToURL( new URLRequest(myurl), window )
		}
		
		
		public static function attach ( linkage, params:Object=null, container = null)
		{
			var linkage = linkage
			
			if ( linkage is String ) 
			{
				linkage = asClass( linkage ) || asClass( "project."+linkage )
			}
			if( !linkage ) return false
			var instance = params ? new linkage( params ) : new linkage()
			if( container ) container.addChild( instance )
			return instance
		}
		
		public static function asClass( name:String ) 
		{
			var clssname 
			try{ clssname = getDefinitionByName( name ) as Class  }catch(e){}finally{}
			return clssname
		}

		public static function toBoolean(v) 
		{
			if (v == "true") {
				return true;
			}
			return false;
		}

		public static function or(v, n) 
		{
			if (v == null) {
				return n;
			}
			return v;
		}
		
		public static function checkVariable(v, n) 
		{
			return or(v, n);
		}
		
		public static function switchBoolean(v) 
		{
			return v ? false : true;
		}
		
		public static function tracer( target ) 
		{
			trace( StringUtil.toString( target ))
		}	

	}
}
