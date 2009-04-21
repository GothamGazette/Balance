/*------------------------------------------------------------------------------------------------------------------






    LIBRARY CLASS
	
	Universal wrapper for loader, vars, socket, audio, video, sound, data, streams, bitmapdata caching, etc.
	
	Unifies methods for load, start, stop, play, pause, onResult, onFinish, onProgress, onStream, etc.
	
	Shame on Adobe for not making things this way to start with

    Copyright (C) 2008 http://www.cublo.com All Rights Reserved.
	
	
	
	
	
	
--------------------------------------------------------------------------------------------------------------------*/

package geeon.system {

	include "../index.as"
	
	public final class Library {
		
		public static var LOAD_COMPLETE 	: Event = Thread.event( "loadComplete" )
		public static var CACHE_COMPLETE 	: Event = Thread.event( "cacheComplete" )
		public static var DATAMAP 			: Object = { swf:SWFWrapper,  flv:VideoWrapper, xml:VARSWrapper, php:VARSWrapper, txt:VARSWrapper, jpg:ImageWrapper, png:ImageWrapper, gif:ImageWrapper }
		
		public static var assetTotal			: int
		public static var assetLoaded		: int
		public static var assetPercent		: int
		public static var assetBar			: MovieClip
		public static var assetPool 			: Array = []
		
		public static var cacheTotal		: int
		public static var cacheLoaded		: int
		public static var cachePercent		: int
		public static var cacheBar			: MovieClip
		public static var cachePool 		: Dictionary = new Dictionary()
		

		// LOAD
		
		public static function load( params:Object, args=null ) {

			if ( params is Array ) { 
				while (list.length) { load( params.shift() )}
				return
			}

			if ( params.service ) { 
				return new RemotingWrapper( params ) 
			}
			
			if ( params == MovieClip ) {
				args ? delete cachePool[ params ] : null
				return cachePool[ params ] || new CacheThread( params, args )
			}
			
			var type = params.type || StringUtils.getFileExtension( params.uri )
			
			
			if (type == "mp3") { return new SoundWrapper( params ) }
			
			
			
		}

	
		// FROM POOL
		
		public static function fromPool( params ) {	
			
			var item  	= 	ArrayUtils.getItemByProperty ( assetPool, "uri", params.uri )
			!item		?	item = ArrayUtils.getItemByProperty ( assetPool, "linkage", params.linkage ) : null
			
			if (item) {
				ArrayUtils.extract( params, item )
				item._onResult(true)
				return item
			}
			
			return asset ( params )	
			
		}
		

		// ON CACHE / LOAD
		
		private static function _onCache() {	
			
			++cacheLoaded >= cacheTotal ? Thread.dispatch( CACHE_COMPLETE ) : null
			cachePercent 		= 	Math.round( cacheLoaded * 100 / cacheTotal )
			SpriteUtils.goPercent( cacheBar, cachePercent )
			
		}
		
		private static function _onLoad() {	
			
			++assetLoaded >= assetTotal ? Thread.dispatch( LOAD_COMPLETE ) : null
			assetPercent 		= 	Math.round( assetLoaded * 100 / assetTotal )
			SpriteUtils.goPercent( assetBar, assetPercent )
			
		}
		

	}
}

include "../index.as"

/*------------------------------------------------------------------------------------------------------------------





    LOADER WRAPPER
	
	
	
	

--------------------------------------------------------------------------------------------------------------------*/

class Wrapper extends Proxy{
	
	public var loader
	public var output
	public var bytesLoaded			: Number = 0
	public var bytesTotal			: Number = 0
	public var percentLoaded		: int = 0
	public var stream				: Object
	public var type					: String
	public var id					: Number
	public var preloadbar			: MovieClip
	public var dispatcher
	public var group
	public var tryloadCounter 		: int 
	public var urlrequest			: URLRequest
	public var uri					: String

	// EXTERNAL
	
	public var onProgress			: Function = function(e=null){}
	public var onError				: Function = function(e=null){}
	public var onResult				: Function = function(e=null){}
	
	// OVERRIDES
	
	public function onProgress_private(){}
	public function onError_private(){}
	public function onResult_private(){}
	public function call_private( a:String, b:Array ) {}
	public function load(){}
	public function constructor(){}

	// CONSTRUCT
	public function Wrapper( params ) {
		
		ArrayUtils.extract( params, this )
		fillPreloadbar() 

		!type 						?	type = StringUtils.getFileExtension ( uri ) : null			
		uri							?	urlrequest 	= 	new URLRequest(uri) : null

		constructor()	
		

		dispatcher.addEventListener( Event.COMPLETE, 						_onResult )
		dispatcher.addEventListener( ProgressEvent.PROGRESS, 				_onProgress )
		dispatcher.addEventListener( IOErrorEvent.IO_ERROR,					_onError )
		dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR, 	_onError )
		dispatcher.addEventListener( NetStatusEvent.NET_STATUS, 			_onProgress )
		load()
	}

	// ON LOAD PROGRESS
	public function _onProgress(e){

		bytesLoaded 			= 	e.bytesLoaded
		bytesTotal 				=	e.bytesTotal
		onProgress_private()
		percentLoaded 			=	bytesLoaded * 100 / bytesTotal
	//	streamSlider 			? 	streamSlider.fillPreloadBar(percentLoaded) 	: nul
		fillPreloadbar() 
		onProgress( percentLoaded )
	}

	
	// COMPLETE
	public function _onResult(e) {
		onResult_private()
		fillPreloadbar()
		output ? onResult( output ) : onResult()	
	}
	
	// ERROR
	public function _onError(e) {
		percentLoaded = 0
		fillPreloadbar()
		if ( ++tryloadCounter < 3 ) {
			load()
			return
		}
		onError_private()
		onError()
		
	}
	
	// FILL PRELOAD BAR 
	public function fillPreloadbar() {
		if (!preloadbar) { return }
		preloadbarMc.visible  	= 	percentLoaded > 0 && percentLoaded < 100
		preloadbarMc.gotoAndStop ( Math.round( Math.round( percentLoaded ) ))
	}
	
	// PROXY
	flash_proxy override function callProperty( methodName:*, ...args ):* {
		try { call_private(methodName, args) }catch(error:Error) {}
		return null
		
	}

}

/*------------------------------------------------------------------------------------------------------------------




    VARS
	
	


--------------------------------------------------------------------------------------------------------------------*/


class VARSWrapper extends Wrapper {
	
	public static var counter	: int = 0
	public function VARSWrapper( params ) { super( params ) }

	override public function constructor() {
		loader 			= 	new URLLoader()
		dispatcher 		=	loader
	}
	
	override public function load() { 
		loader.load( urlrequest ) 
	}

	override public function onResult_private() { 
		output			=	type == "xml" ? XMLParser.toObject( loader.data ) : loader.data 
	}

	public function reload( params:String , loadcomplete = null ) {
		loader.load( new URLRequest( uri + "?" + params +"&_forceDataRefresh=" + Math.random()) )
		loadcomplete 	? 	onResult = loadcomplete : null
	}

}


/*------------------------------------------------------------------------------------------------------------------





    REMOTING
	
	include "geeon/importer.as"

	// remoting
	var serviceProxy = new Connector({uri:"http://test.com/gateway.aspx", service:"ServiceName", onResult:onResult, onFault:onFault, onError:onError});
	serviceProxy.CallMethod(params)
	
	
	function onError(event):void {
		Utils.tracer(event);
	}
			
	function onFault(event):void {
		Utils.tracer(event);
	}
	
	function onResult(event):void {
		Utils.tracer(event);
	}
	
	

--------------------------------------------------------------------------------------------------------------------*/


class RemotingWrapper extends Wrapper {

	public var service				: String
	public static var counter		: int = 0
	public function RemotingWrapper( params ) { super( params ) }
	
	override public function constructor() {
		loader 						= 	new NetConnection()
		loader.client 				= 	this
		loader.objectEncoding 		= 	ObjectEncoding.AMF0	
		dispatcher					=	loader
	}
	
	override public function load() { 
		loader.connect(uri)
	}
	
	override public function _onResult( e ) {
		output						= 	e	
		onResult( output )
	}
	
	override public function call_private(methodName:String, arguments:Array) {
		var responder:Responder 	= 	new Responder( _onResult, _onError )
		var operationPath:String 	= 	service + "." + methodName.toString()
		var callArgs:Array 			= 	new Array( operationPath, responder )
		connection.call.apply( null, callArgs.concat(arguments) )
	}

}


/*------------------------------------------------------------------------------------------------------------------










    MEDIA WRAPPER
	
	
	
	
	
	
	
	
	
	

--------------------------------------------------------------------------------------------------------------------*/

class MediaWrapper extends Wrapper {
	
	public var fitArea
	public var mouseDown
	public var button
	public var area_mc					: MovieClip
	public var linkage 					: String
	public var target
	public var blocked					: Boolean = false
	public var playing					: Boolean = true
	public var soundChannel				: SoundChannel
	public var volume					: Number = 1
	public var pan						: Number = 0
	public var duration					: Number = 10000000
	public var position					: Number = 0
	public var percentPlayed			: Number = 0
	public var streamSlider
	public var time						: Number = 0
	public var totalTime				: Number = 0
	public var timeMc					: MovieClip
	public var container 				: Sprite
	public var context 					: LoaderContext
	public var loop						: uint
	public var buffer					: Number = 1000

	public var onStart 					: Function = function (e){}
	public var onFinish					: Function = function () { }
	
	public function custom_update(){}
	public function custom_onFinish(){}
	public function custom_stop(){}
	public function start_private(){}
	public function play_private(){}
	public function custom_pause(){}
	public function custom_seek(){}
	
	public function MediaWrapper ( params ) {

		super ( params )
		
		context					=	Document.context//params.context || Document.context	//true, ApplicationDomain.currentDomain 
		streamSlider 			?	streamSlider.seHolder( this ) : null
		
	}
	
	public function start() {
		playing 			= 	true
		start_private()
	}

	public function play() {
		if (playing)		{ return }
		playing 			= 	true
		play_private()
	}

	public function pause() {
		if (!playing) 		{ return }
		playing 			= 	false
		custom_pause()
	}
	
	public function stop() {
		playing 			= 	false
		soundChannel 		? 	soundChannel.stop() : null
		custom_stop()
		Thread.remove( update )
	}

	public function seek ( pos, release = false) {
		custom_seek( pos, release )
		blocked 			= 	!release
	}
	
	public function _onFinish(e) {
		stop()
		custom_onFinish()
		onFinish()
	}
	
	public function update(){
		percentPlayed 				= 	position * 100 / duration
		percentPlayed >= 100 		? 	_onFinish() : null 
		custom_update()
		streamSlider && !blocked	? 	streamSlider.setPercent( percentPlayed ) : null
		timeMc 						? 	timeMc.fieldTime.text = StringUtils.seconds2Minutes( stream.time ) : null
	}

}

/*------------------------------------------------------------------------------------------------------------------





    IMAGE
	
	
	

--------------------------------------------------------------------------------------------------------------------*/

class ImageWrapper extends MediaWrapper {
	
	public static var counter		: int = 0
	
	public function ImageWrapper( params ) { 
		
		super( params ) 
		
		Library.loadPool.push( this )
		Library.loadTotal ++
		
	}
	
	override public function constructor() {
		
		loader 		= 	new Loader()
		dispatcher 	=	loader.contentLoaderInfo

	}
	
	override public function load() {
		loader.load( urlrequest )
	}
	
	override public function onResult_private() {

		output 		=	loader.content
		container 	? 	container.addChild( output ) : null
		fitArea 	? 	Align.fit( output, fitArea ) : null
		
		Library._onLoad()
		
	}

	
}

/*------------------------------------------------------------------------------------------------------------------





    SWF
	
	
	

--------------------------------------------------------------------------------------------------------------------*/

class SWFWrapper extends MediaWrapper {
	
	public static var counter		: int = 0
	public function SWFWrapper( params ) { 	
		
		super( params ) 
		
		Library.loadPool.push( this )
		Library.loadTotal ++
		
	}
	
	override public function constructor() {
		
		loader 		= 	new Loader()
		dispatcher 	=	loader.contentLoaderInfo
		
	}

	override public function load() {
		loader.load( urlrequest, new LoaderContext( false, new ApplicationDomain() ) )
	}

	override public function onProgress_private(){ 
		getContent()
	}

	override public function custom_update(){
		position = stream.currentFrame
	}

	override public function start_private() {
		if( !stream ){ return }
		stream.gotoAndPlay(1)
		play()
	}
	
	override public function onResult_private() {
		
		getContent()
		Library._onLoad()
		
	}
	
	override public function play_private() {
		if( !stream ){ return }
		stream.play()
		Thread.add( update )
	}
	
	override public function custom_pause(){
		stream ? stream.stop() : null
	}
	
	override public function custom_stop(){
		stream ? stream.gotoAndStop(1) : null
	}

	public function getContent() {
		if ( stream || !loader.content ){ return }
		stream		=	output = loader.content
		duration 	= 	stream.totalFrames
		container 	? 	container.addChild( stream ) : null
		playing 	?	start() : stop()
		fitArea 	? 	Align.fit( stream, fitArea ) : null
		onStart( stream )
	}
	
}


/*------------------------------------------------------------------------------------------------------------------





    SOUND
	
	
	

--------------------------------------------------------------------------------------------------------------------*/

class SoundWrapper extends MediaWrapper {
	
	public static var counter		: int = 0
	
	public var sound				: Sound
	public var startOffset			: uint = 0
	
	public function SoundWrapper( params ) { super( params ) }
	
	override public function constructor() {

		stream 					=	linkage ? Utils.attach( linkage ) : new Sound(new URLRequest(uri), new SoundLoaderContext( buffer ))
		dispatcher				=	stream
		dispatcher.addEventListener( Event.ID3, onID3 )
		
	}
	
	override public function load() {
		start()
	}
	
	
	function onID3(e){
		var soInfo 	= ID3Info(stream.id3)
	}
	
	// START
	override public function start_private() {
		
		soundChannel 	? 	soundChannel.stop() : null
		soundChannel 	= 	stream.play( startOffset*1000 , loop )
		soundChannel.addEventListener( Event.SOUND_COMPLETE, onFinish )

	}

}

/*------------------------------------------------------------------------------------------------------------------





    VIDEO
	
	
	

--------------------------------------------------------------------------------------------------------------------*/

class VideoWrapper extends MediaWrapper {
	
	public static var counter		: int = 0
	
	public var video				: Video
	
	public function VideoWrapper( params ) {
		
		id						=	counter++ 
		
		super( params )
		
		video = new Video();
	
		var connection:NetConnection = new NetConnection();
		connection.connect(null);
		
		soundChannel = stream 	= 	new NetStream(connection);
		stream.bufferTime		=	9;
		stream.play(params.uri);
		
		stream.client = {onMetaData:onMetaData}
		video.attachNetStream(stream);
		dispatcher	=	stream;

		target? target.addChild(video) : addChild(video);
		
		//Thread.add(onProgress);
		Thread.add(onStream);
		stream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus, false, 0, true);


		Library.loadPool.push( this )
		Library.loadTotal ++

		
	}
	
	// METADATA
	function onMetaData(data:Object){
		data.duration ? duration = data.duration : null;
		timeMc ? timeMc.fieldTotal.text = Utils.seconds2Minutes(duration) : null;
	}
	
	// NET STATUS
	function onNetStatus(evt:NetStatusEvent){
		video.width = video.videoWidth, video.height = video.videoHeight;
		fitArea ? Utils.fit(video,fitArea) : null;
	}
	
	// ON STREAM
	override public function custom_update(){
		position = stream.time
		//calcPercent()
	}

	// STOP
	override public function custom_stop(){
		stream.seek(0)
	}
	
	// PAUSE
	override public function custom_pause(){
		stream.pause()
	}
	
	// PLAY
	override public function play_private(){
		stream.resume()
	}
	
	// SEEK
	/*
	override public function doSeek (p, release=false){
		stream.seek(p*duration/100);
		!release ? stream.pause() : playing ? stream.resume() : null;
	}*/
	
	// ON LOAD PROGRESS
	override public function onProgress_private(){
		bytesLoaded 	= 	stream.bytesLoaded
		bytesTotal 		=	stream.bytesTotal
		//var evt			=	{type:"onProgress",bytesLoaded:bytesLoaded,bytesTotal:bytesTotal}
	}
	
	override public function onError_private() {
		
		Library._onLoad()
		
	}
	

}


/*------------------------------------------------------------------------------------------------------------------





    CACHE THREAD
	
	
	
	

--------------------------------------------------------------------------------------------------------------------*/

class CacheThread {
		
	public var timeline 		: Array
	public var width			: int
	public var height			: int
	
	public var currentFrame 	: int = 1
	public var movieclip 		: MovieClip
	public var bmp				: BitmapData
	public var labelFrame		: int
	public var lastLabel		: String
	public var label			: String
	
	public var onFrame			: Function		


	public function CacheThread( linkage, $onFrame = null ) {
		
		Quality.render()

		onFrame							= 	$onFrame
		movieclip						=	new linkage()
		width 							= 	movieclip.width
		height 							= 	movieclip.height
		bmp 							= 	new BitmapData( width, height, true, 0x00000000 )
		bmp.draw( movieclip )
		
		timeline 						=	SpriteUtils.getTimeline( movieclip, bmp )
		timeline.width 					=	width
		timeline.height 				=	height
		
		Library.cachePool[ linkage ] 	= 	timeline
		Library.cacheTotal ++
		
		Thread.add( update )

	}
	

	public function update()
	{
		movieclip.gotoAndStop( currentFrame )

		if (!( onFrame == null || onFrame( movieclip ) )) { return }
		
		bmp 									= 	new BitmapData( width, height, true, 0x00000000 ) 
		bmp.draw( movieclip )
		
		timeline[ currentFrame-1 ] 				= 	bmp
		label 									= 	movieclip.currentLabel

		if (label) 
		{ 
			if ( label != lastLabel ){
				lastLabel 						= 	label
				labelFrame 						= 	0
			}
			timeline[ label ][ labelFrame++ ] 	= 	bmp 
		}
		
		if ( ++currentFrame > movieclip.totalFrames ) 
		{
			movieclip.visible 					= 	false
			movieclip 							= 	null
			
			Thread.remove( update )
			Library._onCache()
		}
	}

}


