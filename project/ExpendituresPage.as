package project 
{	
	include "index.as"

	public class ExpendituresPage extends Page
	{
		
		public function ExpendituresPage( target:MovieClip )
		{
			super( target )
			
			var slist 					= 	Memory.config.ExpendituresPage.sliders
			var margin : int 			= 	Memory.config.ExpendituresPage.sliderMargin
			
			SliderItem.textField 		=	target.projected.value
			SliderItem.deficitField 	=	target.changes.value
			
			SliderItem.msgBox 			=	new MsgBox( target.msgBox, Memory.config.ExpendituresPage.tip )
			SliderItem.max 				=	Memory.config.ExpendituresPage.sliderMax
			
			for ( var n in slist) 
			{
				var sliderItem 			= 	new SliderItem( slist[n] ) 
				sliderItem.y 			= 	n * int( margin )
				target.slidersMc.addChild( sliderItem )
			}
			SliderItem.getSum()
			
			Button.pull({ target:target.over_area, mouseOver:SliderItem.msgBox.reset })
		}
		
		override public function show() 
		{
			super.show()
			
			target.lastyear.value.text 	=	StringUtil.toDollars( Memory.global.original.expendings )
			target.changes.value.text 	=	StringUtil.toDollars( Memory.global.current.deficit )
			
			trace( Memory.global.current.deficit , target.changes.value.text )
		}
		
		override public function hide() 
		{
			super.hide()
		}
	}	
}
