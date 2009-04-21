package project 
{	
	include "index.as"

	public class DashboardPage extends Page
	{
		public function DashboardPage( target:MovieClip )
		{
			super( target )
		}
		
		override public function show() 
		{
			super.show()
			
			Memory.global.current.deficit	=	Memory.global.current.revenues - Memory.global.current.expendings
			target.deficit.value.text 		= 	StringUtil.toDollars( Memory.global.current.deficit  )
			target.revenues.value.text 		= 	StringUtil.toDollars( Memory.global.current.revenues )
			target.expenditures.value.text 	= 	StringUtil.toDollars( Memory.global.current.expendings )
		}
		
		override public function hide() 
		{
			super.hide()
		}
	}	
}
