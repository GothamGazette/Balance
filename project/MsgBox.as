package project 
{	
	include "index.as"

	public class MsgBox
	{
		var target 			: MovieClip
		var defaultText 	: String
		
		public function MsgBox( target:MovieClip, defaultText:String )
		{
			this.target 				= 	target
			this.defaultText 			=	defaultText
			reset()
		}
		
		public function reset() 
		{
			target.alert.visible 		=	false
			target.tip.htmlText 			=	defaultText
			Tweenr.fadeIn( target.tip, .5 )
		}
		
		public function showTip( txt ) 
		{
			target.tip.htmlText 			=	txt
			target.alert.visible 		=	false
			Tweenr.fadeIn( target.tip, .5 )
		}
		
		public function showAlert( msg:String = null ) 
		{
			if( !msg || msg.length < 2 ) return
			
			Tweenr.fadeIn( target.alert )
			target.alert.textField.htmlText = msg
		}
		
		public function hideAlert() 
		{
			Tweenr.fadeOut( target.alert )
		}

	}	
}
