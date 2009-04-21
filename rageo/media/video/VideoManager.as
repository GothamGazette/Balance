package rageo.media.video 
{
	include "../index.as"
	
	public class VideoManager 
	{
		public static var dictionary 		: Dictionary = new Dictionary()

		public static function play( target:MovieClip, uri:String, onFinish:Function = null, width:int=0, height:int=0   ) 
		{
			return new VideoWrapper( target, uri, onFinish, width, height )
			//if( !dictionary[uri] )	dictionary[uri] = new VideoWrapper( target, uri, onFinish, width, height )
			//dictionary[uri].play()
			//return dictionary[uri]
		}

	}
}