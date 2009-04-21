package project 
{	
	include "index.as"

	public class ComparePage extends Page
	{
		
		public var scrollBox : ScrollBox
		public var list 	: Array = []
		var slist

		public function ComparePage( target:MovieClip )
		{
			super( target )
			
			slist 					= 	Memory.config.ExpendituresPage.sliders
			var margin : int 		= 	Memory.config.ExpendituresPage.sliderMargin

			for ( var n in slist) 
			{
				var item 		= 	new CompareItem() 
				item.y 		= 	n * int( margin )
				target.scrollBox.content.addChild( item )
				list.push( item )
			}

			scrollBox 				= 	new ScrollBox( target.scrollBox )
			scrollBox.deactivate()
		}

		override public function show() 
		{
			super.show()
			
			if (scrollBox) scrollBox.activate()
			
			for ( var n in list ) 
			{
				var item 				= 	list[n]
				var slider	 			= 	SliderItem.index[n]
				
				item.titleUser.htmlText 	= 	item.titleDefault.htmlText = slider.title.text
				item.valueUser.htmlText 	= 	slider.valueField.text
				item.valueDefault.htmlText 	= 	StringUtil.toDollars( slider.data.value )
			}

			target.totalPlayer.htmlText 	=	StringUtil.toDollars( Memory.global.current.expendings )
			target.totalDefault.htmlText 	=	StringUtil.toDollars( Memory.global.original.expendings )
			
	//		target.percentPlayer.htmlText	=	Math.abs(int( Memory.global.current.deficit * 100/Memory.global.current.expendings ))+"%"
	//		target.percentDefault.htmlText	=	Math.abs(int( Memory.global.original.deficit * 100/Memory.global.original.expendings ))+"%"
		}

		override public function hide() 
		{
			super.hide()
			if(scrollBox) scrollBox.deactivate()
		}
	}	
}
