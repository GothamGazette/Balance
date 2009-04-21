package project 
{	
	import rageo.components.scroll.ScrollBox;
	include "index.as"

	public class LearnMorePage extends Page
	{
		public static var instance 	: MovieClip
		public static function fill( data ) 
		{
			instance.title.text 		= 	data.title
			scrollBox.text 				=	data.info
			scrollBox.activate()
		}
		
		public static var scrollBox 	: ScrollBox
		
		public function LearnMorePage( target:MovieClip )
		{
			super( target )
			instance = target
			Button.pullSimple( target.Back_btn, close )
			scrollBox = new ScrollBox( target.scrollBox )
			scrollBox.deactivate()
		}
		
		function close() 
		{
			Tweenr.fadeOut( target, .4 , hide )
			scrollBox.deactivate()
		}
		
		override public function show() 
		{
			super.show()
			Tweenr.fadeIn( target, .4 )
		}
		
		override public function hide() 
		{
			super.hide()
		}
	}	
}
