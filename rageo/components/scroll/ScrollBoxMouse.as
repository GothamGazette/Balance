package rageo.components.scroll 
{
	include "../index.as"
	
	public class ScrollBoxMouse 
	{
		
		public var autoSize			: String = "left"
		
		private var target 			: MovieClip
		private var horizontal 		: Boolean
		private var rect 			: Rectangle
		private var offset 			: Point = new Point()
		private var slide 			: Sprite = new Sprite()
		private var content 		: MovieClip
		private var area 			: MovieClip
		private var scroll 			: Number 
		private var margin 			: Number
		private var textField		: TextField

		public function ScrollBoxMouse( target:MovieClip, text:String="", horizontal:Boolean = false ) 
		{
			this.target 			=  	target
			this.horizontal 		=	horizontal
			content 				=	target.content
			content.x				=	content.y = 0
			textField				=	content.textField
			area 					=	target.area
			rect 					=	new Rectangle(0, 0, target.area.width, target.area.height )
			margin					=	rect.height * .2
			
			slide.addChild( content )
			target.addChild( slide )
			
			this.text 				=	text
			
			refresh()
		}
		
		public function set text ( value:String ) 
		{
			if ( !textField ) return
			
			textField.text 		= 	value 
			textField.autoSize 	=	autoSize
			
			refresh()
		}
		
		public function refresh() 
		{
			offset.y 				=	content.height  - rect.height
			slide.scrollRect 		=	rect
			rect.y 					=	0
			scroll					=	0

			if( offset.y > 0 ) Cycle.add( step )
		}
		
		public function activate() 
		{
			refresh()
		}
		
		public function deactivate() 
		{
			Cycle.remove( step )	
		}
		
		private function step() 
		{
			rect.y 					+= 	(scroll - rect.y)/4
			slide.scrollRect 		=	rect
			
			if( !HitTest.mouse( area ) ) return

			scroll = MathUtil.constrain( ( target.mouseY - margin ) * offset.y / (rect.height - margin * 2) , 0, offset.y )
		}
	}
	
}