package rageo.net.connector
{	
	include "../index.as"
	
	public class URLConnector
	{
		public var loader			: URLLoader = new URLLoader()
		public var uri				: String;
		public var type				: String 
		public var data
		public var urlrequest		: URLRequest

		public var onResult			: Function
		public var onFault			: Function
		public var onError			: Function
		public var onProgress		: Function 
		public var reloadCounter 	: int = 0

		public function URLConnector( uri:String, onResult:Function=null, onProgress:Function=null, onError:Function=null, type:String="vars" ) 
		{
			this.uri 				= 	uri
			this.onResult			=	onResult
			this.onError			=	onError
			this.onProgress			=	onProgress
			this.type				= 	StringUtil.getFileExtension(uri)== "xml" ? "xml" : type
			urlrequest 				= 	new URLRequest(uri)
			
			loader.addEventListener( Event.COMPLETE, 						_Complete )
			loader.addEventListener( ProgressEvent.PROGRESS, 				_Progress )
			loader.addEventListener( IOErrorEvent.IO_ERROR,					_Error )
			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, 	_Error )
			
			reload()
		}

		/*-------------------------------------------------------------
		
		INTERNAL LISTENERS // 
		
		--------------------------------------------------------------*/
		
		private function _Complete( e:Event ) 
		{
			
			data							=	loader.data 

			if ( data == false && reloadCounter < 10 ) 
			{ 
				trace("GOT BAD DATA, RELOAD" )
				reload() 
				return
			}
			
			if ( data is String && data.length < 10 ) return

			if( type == "xml" )		data 	= 	XMLUtil.toObject( data )
			if( type == "json" ) 	data 	= 	JSON.deserialize( data )

			if( onResult != null ) onResult( data )
		}

		private function _Progress( e:Event ) 
		{
			if( onProgress != null )  onProgress()
		}
		
		private function _Error( e:Event ) 
		{
			trace( "Error", e )
			if( onError != null ) onError()
		}
		
		/*-------------------------------------------------------------
		
		LOAD METHODS // 
		
		--------------------------------------------------------------*/
		
		private function reload()
		{
			++reloadCounter 
			loader.load( urlrequest )
		}
		
		public function load( actionParam:String="action=getScores&user=yohami" , onResult:Function = null ) 
		{
			var req 			=	uri + "?" + actionParam +"&_forceRefresh=" + Math.random()
			trace("request!", req )
			urlrequest 			= 	new URLRequest( req )
			reloadCounter 		= 	0
			this.onResult 		=	onResult
			reload()
		}


	}
}

