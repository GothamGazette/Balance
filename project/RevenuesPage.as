package project 
{	
	import rageo.components.scroll.ScrollBox;
	include "index.as"

	public class RevenuesPage extends Page
	{
		private var scrollBox	: ScrollBox
		
		public function RevenuesPage( target:MovieClip )
		{
			super( target )
			
			var city 				=	target.scrollBox.content.city
			var state 				=	target.scrollBox.content.state
			
			city.title.htmlText 	=	Memory.config.RevenuesPage.cityTitle
			state.title.htmlText 	=	Memory.config.RevenuesPage.stateTitle
			
			var margin : int 		= 	Memory.config.RevenuesPage.sliderMargin
			var slist
			var n
			var item

			RevenuesItem.textField 		=	target.projected.value
			RevenuesItem.deficitField 	=	target.changes.value
			
			RevenuesItem.msgBox 	=	new MsgBox( target.msgBox, Memory.config.RevenuesPage.tip )
			RevenuesItem.max 		=	Memory.config.RevenuesPage.sliderMax

			slist 					= 	Memory.config.RevenuesPage.city
			for ( n in slist) 
			{
				item 				= 	new RevenuesItem( slist[n] ) 
				item.y 				= 	n * int( margin )  + margin + 5
				city.addChild( item )
			}

			slist 					= 	Memory.config.RevenuesPage.state
			for ( n in slist) 
			{
				item 				= 	new RevenuesItem( slist[n] ) 
				item.y 				= 	n * int( margin )  + margin + 5
				state.addChild( item )
			}
				
			state.y 				=	city.y + city.height + margin + 5
			
			
			
			RevenuesItem.originalSum = RevenuesItem.getSum()
			
			scrollBox 	= new ScrollBox( target.scrollBox )
			scrollBox.deactivate()
		}
		
		override public function show() 
		{
			super.show()
			if (scrollBox) scrollBox.activate()
			
			target.lastyear.value.text 	=	StringUtil.toDollars( RevenuesItem.originalSum )
			target.changes.value.text 	=	StringUtil.toDollars( Memory.global.current.deficit )
		}
		
		override public function hide() 
		{
			super.hide()
			if(scrollBox) scrollBox.deactivate()
		}
	}	
}
