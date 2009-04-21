package rageo.components.page
{
	include "../index.as"

	public class PageManager
	{
		public static var pages 			: Dictionary = new Dictionary()
		public static var pageclass			: Dictionary = new Dictionary()
		public static var current 			: Page
		public static var last 				: Page
		public static var mute 				: Boolean = true
		public static var mouseDown 		: Function = function() { }
		public static var assets 			: MovieClip

		public static function scan( target:MovieClip )
		{
			assets 			=	target
			var childs 		= 	SpriteUtil.getChilds( assets )

			for ( var n in childs ) pages[ childs[n].name ] = Utils.attach( childs[n].name, childs[n] ) || new Page( childs[n] )

			SpriteUtil.removeChild( assets )
			_mouseDown( "SplashPage" )

		}
		
		public static function getObject( name:String, object:String )
		{
			if( ! pages[ name ] ) return
			return  pages[ name ].target[ object ]
		}
		
		public static function show( name:String ) 
		{
			if ( !pages[ name ] ) return
			if ( current ) current.hide()
			
			last		=	current
			current 	=	pages[ name ]
			current.show()
		}
		
		public static function overlay( name:String ) 
		{
			var page 	=	pages[ name ]
			SpriteUtil.toFront( page.target )
			page.show()
		}
		
		public static function hide( name:String )
		{
			pages[ name ].hide()
		}

		public static function back() 
		{
			current.hide()
			var prev 	=	current
			current 	=	last
			last 		=	prev
			current.show()
		}
		
		public static function _mouseDown( name:String ) 
		{
			if ( pages[name] )
			{
				show( name )
			//	var scoreField : TextField = getObject( name, "scoreField" )
			//	if ( scoreField ) scoreField.text = StringUtil.commas( Counter.value("score") )
			}
			mouseDown( name )
		}

	}	
}