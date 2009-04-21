package rageo.system.threading
{	
	include "../index.as"
	
	public class Thread 
	{

		public var times 			: int
		public var bucle			: int
		public var stepInterval		: int
		public var onFinish 		: Function
		public var onUpdate 		: Function
		public var playing 			: Boolean
		public var onFinishParams 	: Object
		
		public function Thread () {}

		public function start ( onUpdate:Function = null, times = 100, stepInterval:int = 0, onFinish:Function = null, onFinishParams:Object = null ) 
		{
			this.times 				=	times
			this.onUpdate 			=	onUpdate
			this.stepInterval 		=	stepInterval 
			this.bucle				=	stepInterval
			this.onFinish 			=	onFinish
			this.onFinishParams 	=	onFinishParams
			playing 				=	true

			Cycle.add( update )
		}
		
		public function extract ( params:Object ) 
		{
			ArrayUtil.extract( params, this )
		}	
		
		public function delay( onFinish, times = null, onFinishParams = null ) 
		{
			start ( null, times, 0, onFinish, onFinishParams )
		}

		public function update() 
		{
			if( !playing ){ return }
			
			if ( stepInterval ) 
			{
				if ( !--bucle ) { return }
				bucle = stepInterval
			}
			
			onUpdate != null ? onUpdate() : null

			if ( !--times )
			{
				Cycle.remove( update )
				playing 	= 	false
				onFinish 	!= 	null 	? 	onFinishParams ? onFinish( onFinishParams ) : onFinish() : null
			}
		}
		
		public function stop() 
		{
			playing = false
			Cycle.remove( update )
		}
		
	}
}
