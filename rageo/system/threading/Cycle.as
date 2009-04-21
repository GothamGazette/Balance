package rageo.system.threading
{	
	include "../index.as"
	
	public class Cycle 
	{
		private static var cycledict		: Dictionary = new Dictionary()
		private static var renderdict		: Dictionary = new Dictionary()
		private static var playing 	 		: Boolean
		private static var fps				: int = 45
		private static var timer			: Timer = new Timer( 100/fps )
		private static var onUpdate 		: Function

		
		public static function start() 
		{
			timer.delay 				= 	1000 / fps
			timer.addEventListener( "timer", update )
			play() 
		}

		public static function play() 
		{
			playing 		=	true
			timer.start()
			update()
		}
		
		public static function pause() 
		{
			playing 		=	false
		}
		
		public static function stop() 
		{
			playing 		=	false
			timer.stop()
		}
		
		public static function add( listener:Function, unpausable:Boolean = false )
		{
			remove ( listener )
			unpausable 	?	renderdict[ listener ] = true 	: cycledict[ listener ] = true 
		}
		
		public static function remove( listener:Function )
		{	
			delete cycledict[ listener ]
			delete renderdict[ listener ]
		}

		public static function update( e:TimerEvent = null )
		{
			var n 
			for ( n in renderdict ) { n() }
			if( playing ) for ( n in cycledict ) { n() }
			
			if (e) e.updateAfterEvent()
		}
		
	}
}
