
package rageo.media.sound 
{
	include "../index.as"
	
	public class SoundManager 
	{

		public static var volume 			: Number = 1
		public static var pan 				: Number = 0
		public static var soundTransform 	: SoundTransform = new SoundTransform( 1, 0 )
		
		public static var _mute 			: Boolean = false	
		public static var dictionary 		: Dictionary = new Dictionary()
		
		public static var groups 			: Object = {}	
		public static var MUSIC 			: SoundGroup //= addSoundGroup( "MUSIC", false ) 
		public static var FX 				: SoundGroup //= addSoundGroup( "FX" ) 
		
		public static function addSoundGroup( name:String, poly:Boolean=true ) 
		{	
			!groups[ name ] ? groups[ name ] = new SoundGroup( name ) : null
			return groups[ name ]
		}

		public static function play( params:Object  ) 
		{
			var linkage 	=	params.linkage
			var group 		=	params.group
			var item 		=	dictionary[linkage]
			
			!item			?	item = dictionary[linkage] = new SoundWrapper( params ) : null
			
			item.start()
			return item
		}
		
		public static function stop( params:Object  ) 
		{
			var linkage 	=	params.linkage
			var group 		=	params.group
			var item 		=	dictionary[linkage]
			
			!item			?	item = dictionary[linkage] = new SoundWrapper( params ) : null

			item.stop()
			return item
		}
		
		public static function playFX( linkage, pan:Number = 0, loop:Number = 0, onFinish:Function = null ) 
		{
			!FX  ? FX = addSoundGroup( "FX" ) : null
			return play({ linkage:linkage, group:"FX", pan:pan, loop:loop, onFinish:onFinish })
		}
		
		public static function stopFX( linkage ) 
		{
			!FX  ? FX = addSoundGroup( "FX" ) : null
			return stop({ linkage:linkage, group:"FX" })
		}
		
		public static function playMusic( linkage ) 
		{
			!MUSIC  ? MUSIC = addSoundGroup( "MUSIC", false ) : null
			return play({ linkage:linkage, group:"MUSIC", loop:999999, allowInterrupt:false })
		}
		
		public static function stopAll()
		{
			for ( var n in groups ) groups[n].stop()
		}
		
		public static function mute()
		{
			_mute = true
			soundTransform.volume 		=  0 
			SoundMixer.soundTransform 	= 	soundTransform
		}
		
		public static function soundsOn()
		{
			_mute = false	
			soundTransform.volume 		=  	volume
			SoundMixer.soundTransform 	= 	soundTransform
		}
		
		
		
		public static function update()
		{
			soundTransform.pan 			=	pan
			SoundMixer.soundTransform 	= 	soundTransform
	
			if ( _mute ) { return }
			
			soundTransform.volume 		=  	volume
			SoundMixer.soundTransform 	= 	soundTransform

			for ( var n in dictionary ) 
			{	
				var item:SoundWrapper 					= 	dictionary[n]
				
				if ( item.soundChannel == null ) continue
				
				var soundTransform:SoundTransform 		= 	item.soundChannel.soundTransform
				var soundGroup:SoundGroup 				=	item.soundGroup
				soundTransform.volume 					= 	item.volume * soundGroup.volume 
				soundTransform.pan 						=	item.pan + soundGroup.pan
				item.soundChannel.soundTransform 		= 	soundTransform	
			}
			
			
		}

	}
}