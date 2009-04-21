package rageo.gaming.level 
{	
	include "../index.as"

	public class Level
	{
		
		public var levelId 		: int
		public var levelTime 	: int = 60
		
		public function Level( params:Object = null )
		{
			levelId 	=	LevelManager.pool.length
			//if ( !params ) ArrayUtil.extract( Memory.config.levels[levelId], this )
		}
		
		public function start() 
		{
			Time.initialize( levelTime, 0, _onTimeOut )
		}
		
		public function stop() 
		{
			
		}
		
		public function hide() 
		{
			
		}
		
		public function _onFinish() 
		{
			Time.stop()
			LevelManager._onFinishLevel()
		}
		
		public function _onLose() 
		{
			Time.stop()
			LevelManager._onLoseLevel()
		}
		
		public function _onTimeOut() 
		{
			Time.stop()
			LevelManager._onLoseLevel()
		}

		
	}	
}
