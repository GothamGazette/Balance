
package gna.uicomponents
{
	include "../_import.as"
	
	public class ScoreScroller 
	{
		public static var target		: MovieClip
		public static var numberField 	: TextField
		public static var userField 	: TextField
		public static var scoreField 	: TextField
		public static var sliderMc 		: MovieClip
		public static var scrollBox 	: ScrollBox
		public static var instance 		: ScoreScroller
		
		public static var d 			: Array
		public static var counter 		: int
	
		public function ScoreScroller( target:MovieClip )
		{
			
			instance 				=	this
			ScoreScroller.target 	= 	target

			sliderMc 				=	target.sliderMc
			numberField 			=	target.containerMc.numberField 
			userField 				=	target.containerMc.userField
			scoreField 				=	target.containerMc.scoreField 
	
			scrollBox				=	new ScrollBox({ target:target })
			
			numberField.autoSize 	= 	userField.autoSize = scoreField.autoSize = "left"
			
			hide()
			
		}
		
		public static function hide()
		{
			numberField.text 	= 	scoreField.text = ""
			userField.text 		= 	"Loading..."
		}
		
		public static function show( data )
		{
			numberField.text = userField.text = scoreField.text = ""

			for(var n in data )	//for(var n =0;n<100;n++ ) 
			{
				numberField.appendText( StringUtil.fillZero( n + 1 )  +"\n" )
				userField.appendText( data[n].user +"\n"  )
				scoreField.appendText( StringUtil.commas( data[n].score ) +"\n" )
			}
			
			numberField.autoSize 	= 	userField.autoSize = scoreField.autoSize = "left"
			
			scrollBox.refresh()
		
		}
		
		
	}
}