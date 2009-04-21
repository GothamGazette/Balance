package rageo.media.video 
{
	include "../index.as"

	public class VideoWrapper 
	{

		public var target				: MovieClip
		public var uri			 		: String
		public var bufferTime 			: Number = 9
		public var duration 			: Number
		public var position 			: Number
		public var width 				: int = 0
		public var height 				: int = 0
		public var onFinish 			: Function
		public var video 				: Video = new Video()
		public var percentPlayed		: Number
		
		private var netConnection 		: NetConnection = new NetConnection()
		private var netStream			: NetStream
		private var playing 			: Boolean
		private var soundChannel		: SoundChannel
		private var started 			: Boolean

		public function VideoWrapper( target:MovieClip, uri:String, onFinish:Function = null, width:int=0, height:int=0 ) 
		{
			this.target				= 	target
			this.uri 				= 	uri
			this.bufferTime			=	bufferTime
			this.width 				=	width
			this.height 			=	height
			this.onFinish 			=	onFinish
			
			video.width 			= 	width || 320
			video.height 			=	height || 240

			netConnection.connect( null )
			
			netStream 				= 	new NetStream( netConnection )
			netStream.bufferTime 	=	bufferTime
			netStream.client 		= 	{ onMetaData:onMetaData }
			
			netStream.play( uri )
			video.attachNetStream( netStream )

			netStream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus )
			
			play() 
		}
		
		function onMetaData( data:Object )
		{
			duration = data.duration
			target.durationText ? target.durationText.text = StringUtil.seconds2Minutes(duration) : null
		}
		
		function onNetStatus(evt:NetStatusEvent)
		{
			if ( width || !video.videoWidth ) return

			width = video.width 	= video.videoWidth
			height = video.height 	= video.videoHeight
			
			target.addChild( video )

			if ( target.areaMc ) SpriteUtil.fit( video, target.areaMc ) 
			Tweenr.fadeIn( video )
		}
		
		public function play() 
		{
			if (playing)			return 
			playing 			= 	true
			video.visible		=	true
			netStream.resume()
			Cycle.add( onVideoFrame )
		}

		public function pause() 
		{
			if (!playing) 			return 
			playing 			= 	false
			netStream.pause()
			Cycle.remove( onVideoFrame )
		}
		
		public function stop() 
		{
			playing 			= 	true
			soundChannel 		? 	soundChannel.stop() : null
			pause() 	
			netStream.seek(0)
			position			=	0
			video.visible		=	false
		}

		public function goto ( pos:Number, andPlay:Boolean=true ) 
		{
			video.visible		=	true
			netStream.seek( pos * duration / 100 )
			andPlay ? play() : pause()
		}

		private function onVideoFrame()
		{
			position 					= 	netStream.time
			target.positionText 		? 	target.positionText.text = StringUtil.seconds2Minutes( position ) : null
			percentPlayed 				= 	position * 100 / duration
			percentPlayed >= 100 		? 	onVideoFinish() : null 
		}
			
		private function onVideoFinish() 
		{
			stop()
			onFinish != null 			?	onFinish() : null
		}


	}
}
