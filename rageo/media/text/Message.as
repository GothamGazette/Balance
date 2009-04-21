package rageo.media.text 
{
	include "../index.as"

	public class Message
	{

		public static var targets 		: Array = []
		public static var container 	: MovieClip
		public static var pool 			: Array = []

		public static function search( container:MovieClip ) 
		{
			
			Message.container 	=	container
			var childs 			= 	SpriteUtil.getChilds( container )
			
			for ( var n in childs ) 
			{
				var target 	=	childs[n]
				
				if ( target is MovieClip && String( target.name.toLowerCase() ).indexOf( "_message" ) ) 
				{
					var prefix 	: String 	=	target.name.split("_")[0]
					targets[ prefix ] 		=   new ( Object(target).constructor ) ()  //	new TextItem()
				}
			}
		}
		
		public static function show( type:String, message:String, x:int, y:int ) 
		{
	
			if ( !targets[type] ) return 

			/*
			var bitmaptext 	: BitmapText
			var typePool 	: Array = pool[type]

			for ( var n in typePool ){
				if ( ! typePool[n].transitioning ){
			//		bitmaptext = typePool[n]
					break
				}
			}
			if ( !bitmaptext ) 
			{
				bitmaptext = new BitmapText( { target:targets[type] } ) 
				if ( !pool[type] ) pool[type] = []
				pool[type].push( bitmaptext )
			}
			*/
			
			var bitmaptext //= new BitmapText( { target:new CrapMessage() } )  //   targets[type]

			bitmaptext.play( { text:message, x:x, y:y, alpha:1, tweenParams: { y:y - 40, alpha:0 } } ) //, alpha:1, ease:Easing.easeInOut, bezierThrough:[ { y:y - 20, alpha:1 } ]
			Document.root.addChild( bitmaptext )

		}
		
		
	}

}

