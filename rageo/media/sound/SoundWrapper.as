
package rageo.media.sound 
{
	include "../index.as"
	
	public class SoundWrapper 
	{
		public var linkage 		
		public var sound				: Sound
		public var offset				: uint = 0
		public var soundChannel			: SoundChannel
		public var loop	 				: int = 0
		public var buffer 				: Number = 1000
		public var _volume 				: Number = 1
		public var pan 					: Number = 0
		public var onFinish 			: Function = function() { }
		public var group 				: String = "FX"
		public var allowInterrupt 		: Boolean = true
		public var soundGroup 			: SoundGroup
		public var playing				: Boolean
		public var soundTransform 		: SoundTransform = new SoundTransform()

		public function SoundWrapper( params:Object ) 
		{
			ArrayUtil.extract( params, this )
	 
			if ( StringUtil.getFileExtension( linkage ) == "mp3" ) {	
				sound = new Sound(new URLRequest(linkage), new SoundLoaderContext( buffer )) 
			}else {
				sound = Utils.attach( linkage ) 	
				
				if (!sound)
				{
					return
				}
			}
			
			
			soundGroup 		= 	SoundManager.addSoundGroup( group )
			soundGroup.push( this )
		}

		public function start() 
		{
			if( playing && !allowInterrupt ){ return }
			
			!soundGroup.poly 					?	soundGroup.stop() : null
			soundChannel 						? 	soundChannel.stop() : null
			soundChannel 						= 	sound.play( offset * 1000 , loop )
			soundChannel.soundTransform 		= 	soundTransform	
			soundChannel.addEventListener( Event.SOUND_COMPLETE, finish )
		}
		
		public function stop() 
		{
			if ( soundChannel ) soundChannel.stop()
		}
		
		public function finish( e=null ) 
		{
			stop()
			onFinish != null ? onFinish() : null
		}
		
		public function get position() 
		{
			return soundChannel.position
		}
		
		public function set volume( value )
		{
			_volume 				= 	value
			soundTransform.volume 	= 	value
			soundChannel			?	soundChannel.soundTransform   = 	soundTransform	: null
		}
		
		public function get volume()
		{
			return _volume
		}

	}
}
