package rageo.media.sound 
{
	include "../index.as"
	
	public class SoundGroup
	{
		public var pool		 		: Array = []
		public var volume 			: Number = 1
		public var pan 				: Number = 0
		public var name 			: String
		public var mute 			: Boolean = false
		public var current 			: SoundWrapper
		public var poly				: Boolean 
		
		public function SoundGroup( name:String, poly:Boolean = true ) 
		{
		
			this.name 					= 	name
			this.poly 					= 	poly
			SoundManager.groups[name] 	= 	this
				trace("SOUNDGROUP",name)
		}
		
		public function stop() 
		{
			for ( var n in pool ) { pool[n].stop() }
		}
		
		public function start() 
		{
			for ( var n in pool ) { pool[n].start() }
		}
		
		public function push( soundwrapper ) {
			pool.push( soundwrapper )
		}
		
		
	}

}

