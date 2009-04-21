package rageo.components.page
{
	include "../index.as"

	public class Page 
	{
		public var target 		: MovieClip

		public function Page( target:MovieClip )
		{
			this.target 	= 	target

			Button.search( target, { mute:true, mouseDown:mouseDown } )
			Counter.search( target )
			Message.search( target )

			SpriteUtil.fillFields( target, Memory.config.Default )
			SpriteUtil.fillFields( target, Memory.config[target.name] )
			
			Document.root.addChild( target )	
			hide()
		}
		
		public function show() 
		{
			target.visible = true
			Tweenr.fadeIn( target, .7 )
			Cycle.add( _nextFrame, true )
		}
		
		public function hide() 
		{
			target.gotoAndStop(1)
			target.visible = false
		}
		
		private function _nextFrame() 
		{
			target.nextFrame()
			if( target.currentFrame == target.totalFrames ) Cycle.remove( _nextFrame )
		}
		
		public function mouseDown( name:String ) 
		{
			PageManager._mouseDown( name )
		}
		
	}	
}
