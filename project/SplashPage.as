package project 
{	
	include "index.as"

	public class SplashPage extends Page
	{
		public function SplashPage( target:MovieClip )
		{
			super( target )
			
			var object = {}
			var sliders
			var sum : Number = 0
			var state : Number = 0
			var city : Number  = 0
			var n
			
			sum 						= 	0
			sliders 					=	Memory.config.ExpendituresPage.sliders
			for ( n in sliders ) sum 	+= 	Number(sliders[n].value)
			object.expendings 			=	sum

			object.revenues 			=	RevenuesItem.originalSum
			object.deficit 				=	object.revenues - object.expendings

			Memory.global.original 		= 	object
		}
		
		override public function show() 
		{
			super.show()
			Memory.global.current 		= 	ArrayUtil.extract( Memory.global.original, { } )
			
			SliderItem.reset()
			RevenuesItem.reset()
		}
		
		override public function hide() 
		{
			super.hide()
		}
	}	
}
