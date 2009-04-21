package rageo.components.scroll 
{
	include "../index.as"
	
	public class ScrollBox 
	{
		public var autoSize		: String = "left"
		public var content 		: MovieClip 
		
		private var slider		: Slider
		private var textField	: TextField
		private var rectangle	: Rectangle
		private var height		: Number
		private var offset		: Number
		private var percent		: Number = 0
		private var slide 		: Sprite = new Sprite()
		

		public function ScrollBox ( target:MovieClip, text:String = "" )
		{

			content 			=	target.content
			textField 			=	content.textField

			rectangle			=	new Rectangle( 0, 0, content.width , target.slider.height )
			content.x			=	content.y = 0
			
			slide.addChild( content )
			target.addChild( slide )

			slider				=	new Slider( target.slider, onChange )

			new Slider( target.slider )
		
			this.text  			= 	text
			
			refresh()
		}
		
		
		public function set text ( value:String ) 
		{
			if ( !textField ) return

			textField.htmlText 	= 	value 
			textField.autoSize 	=	autoSize
			
			refresh()
		}
		
		public function addChild( sprite ) 
		{
			SpriteUtil.removeChilds( content )
			content.addChild( sprite )
			refresh()
		}
		
		public function refresh() 
		{
			percent					=	0
			rectangle.y 			= 	0
			slide.scrollRect 		= 	rectangle

			Cycle.remove( step )
			
			slider.setPosition( 0 )
			slider.hide()
			
			height					=	content.height
			offset 					=	height  - rectangle.height
			
			if ( offset < 0 ) return
			
			Cycle.add( step ) 
			slider.show()
		}

		public function activate() 
		{
			refresh()
		}
		
		public function deactivate() 
		{
			Cycle.remove( step )	
		}

		private function onChange( value:Number )
		{
			percent 				= 	value * offset / 100 
		}
		
		public function step()
		{
			rectangle.y 			+= 	(percent - rectangle.y ) / 5
			slide.scrollRect 		= 	rectangle
		}

	}
}

