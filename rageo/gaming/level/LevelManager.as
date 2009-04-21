package rageo.gaming.level 
{	
	include "../index.as"

	public class LevelManager
	{
		public static var pool 					: Array = []
		public static var level 				: Level
		public static var current				: int = 0
		public static var onWin			 		: Function = function(){}
		public static var onLose				: Function = function(){}
		public static var onLevel 				: Function = function(){}
		public static var levelClass 			: Class 
		
		public static function scan ( levels:Object=null ) 
		{
			var levels = levels || Memory.config.levels
			for ( var n in levels ) pool.push( new levelClass( levels[n] ) )
		}
		
		public static function next() 
		{
			hide() 
			if ( ++current >= pool.length ) 
			{ 
				onWin()
				return
			}
			
			start( current )
		}
		
		public static function hide() 
		{
			for ( var n in pool ) pool[n].hide()
		}
		
		public static function _onFinishLevel() 
		{
			onLevel()
		}
		
		public static function _onLoseLevel() 
		{
			onLose()
		}

		public static function start( cu:int = 0 ) 
		{
			hide()
			current 	=	cu

			Counter.update( "level", cu+1 )

			level = pool[cu]
			level.start()
		}

		public static function mouseDown( e:int ) 
		{
			
		}

		
	}	
}
