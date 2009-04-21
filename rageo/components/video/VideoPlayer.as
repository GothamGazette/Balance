package rageo.components.video
{
	include "../index.as"
	
	public class VideoPlayer
	{
		public var videoWrapper 	: VideoWrapper
		public var slider 			: Slider
		public var target 			: MovieClip
		public var uri 				: String
		public var playing 			: Boolean
		public var onFinish 		: Function
		public var manual 			: Boolean = false
		
		public function VideoPlayer( target:MovieClip, uri:String = null, onFinish:Function = null ) 
		{
			this.target 	=	target
			this.uri 		=	uri
			this.onFinish 	=	onFinish || function(){}
			
			Button.pullSimple( target.controls.play_btn, play )
			Button.pullSimple( target.controls.pause_btn, pause )
			
			slider 			=	new Slider( target.controls.slider, onSlide )

			if( uri ) start()
		}
		
		public function start() 
		{
			if( videoWrapper ) videoWrapper.stop()
			videoWrapper	=	VideoManager.play( target.vidHolder, uri, _onFinish  )
			target.visible = true
			
			play()
		}
		
		public function play( uri:String = null ) 
		{
			Cycle.add( step )
			
			if ( uri ){
				this.uri = uri 
				start()
				return
			}
			
			if ( !videoWrapper ){
				start()
				return
			}
			
			playing = true
			videoWrapper.play()
			
			_displayControls()
			
		}
		
		public function stop() 
		{
			pause()
			if( videoWrapper ) videoWrapper.stop()
		}
		
		public function pause() 
		{
			playing = false
			if( videoWrapper ) videoWrapper.pause()
			_displayControls()
			Cycle.remove( step )
		}
		
		public function hide() 
		{
			stop()
			target.visible = false
		}
		
		private function _onFinish() 
		{
			onFinish()
			stop()
		}
		
		private function onSlide( position:Number ) 
		{
			if (!playing ) play()
			videoWrapper.goto( position ) 
		}

		private function step() 
		{
			if (Input.mouseDown) return
			slider.setPosition( videoWrapper.percentPlayed )
		}

		private function _displayControls() 
		{
			target.controls.play_btn.visible = !playing
			target.controls.pause_btn.visible = playing
		}
		
	}
}

