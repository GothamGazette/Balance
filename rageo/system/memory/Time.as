package rageo.system.memory
{
	include "../index.as"

	public class Time 
	{
		public static var timer 			: uint
		public static var key 				: String = "time"

		public static function initialize( initialValue:int = 60, reachValue:int=0, onReach:Function = null, min = null, max = null )
		{
			Counter.initialize( key, initialValue, reachValue, onReach, min, max )
			start( initialValue )
		}
		
		public static function start( seconds:int = 60 )
		{
			Counter.update( key, seconds )
			stop()
			timer				=	setInterval( step, 1000 )
		}

		public static function increase( seconds:int )
		{
			Counter.increase( key, seconds )
		}
		
		
		public static function stop()
		{
			clearInterval ( timer )
		}
		
		public static function step()
		{
		//	if( !Cycle.playing ) return
			Counter.decrease( key )
			if( Counter.dictionary[key].value == Counter.dictionary[key].reachValue ) stop()
		}

	}
}


	