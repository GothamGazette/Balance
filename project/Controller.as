package project 
{	
	include "index.as"

	Document.loadAssets = true 
	Document.loadConfig = true
	
	public class Controller extends Document
	{	

		public function Controller() 
		{
			SplashPage, DashboardPage, ExpendituresPage, RevenuesPage, ComparePage, SubmitPage
		}
		
		override public function init() 
		{
		}

	}	
}
