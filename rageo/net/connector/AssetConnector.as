package rageo.net.connector
{	
	include "../index.as"
	
	public class AssetConnector
	{
		public var loader			: Loader = new Loader()
		public var uri				: String
		public var type				: String 
		public var urlrequest		: URLRequest
		public var container 		: MovieClip
		public var fitArea 			: Object
		public var bytesLoaded 		: Number
		public var bytesTotal 		: Number
		public var percent 			: int
		public var percentMC 		: MovieClip

		public var onResult			: Function
		public var onFault			: Function
		public var onError			: Function
		public var onProgress		: Function 
		public var reloadCounter 	: int = 0

		public function AssetConnector( uri:String, onResult:Function, onProgress:Function=null, onError:Function=null, container:MovieClip=null, fitArea:Object=null, percentMC:MovieClip=null, type:String="swf" ) 
		{
			this.uri 				= 	uri
			this.onResult			=	onResult
			this.onError			=	onError
			this.onProgress			=	onProgress
			this.type				= 	type
			this.container 			=	container
			this.fitArea 			=	fitArea
			this.percentMC 			=	percentMC
			
			urlrequest 				= 	new URLRequest(uri)
			
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, 						_Complete )
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, 				_Progress )
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR,				_Error )
			loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, 	_Error )
			
			load()
		}

		/*-------------------------------------------------------------
		
		INTERNAL LISTENERS // 
		
		--------------------------------------------------------------*/
		
		private function _Complete( e:Event ) 
		{
			if ( container  ) container.addChild( loader.content )
			if ( fitArea  ) SpriteUtil.fit( loader.content, fitArea ) 
			onResult( loader.content  )
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
		
		private function load()
		{
			loader.load( urlrequest )
		}
		
	

	}
}

