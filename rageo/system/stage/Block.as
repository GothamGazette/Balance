package rageo.system.stage
{
	include "../index.as"
	
	public class Block extends MovieClip
	{
		public static var instance		: Block
		public static var mouseDown		: Function
		public static var autoHide 		: Boolean
		public static var buttonMode 	: Boolean = true
		
		public static function show( $mouseDown:Function = null, $autoHide:Boolean = false, container = null )
		{
			if(!instance) new Block()
			
			Block.mouseDown			=	$mouseDown
			Block.autoHide			=	$autoHide
			instance.visible 		= 	true
			instance.width 			=	Document.width
			instance.height 		=	Document.height
			instance.buttonMode 	=	Block.buttonMode
			var containter 			=	container || Document.root
			containter.addChild( instance )
		}
		
		public static function hide()
		{
			if(!instance) new Block()
			instance.visible = false
		}
		
		public function Block() 
		{
			instance 			= 	this
			GraphicUtil.drawRect( graphics )

			width 				=	Document.width
			height 				=	Document.height

			this.addEventListener( "_mouseDown", _mouseDown )	
			hide()
		}
		
		public function _mouseDown( e:MouseEvent = null )
		{
			trace( mouseDown )
			
			if ( mouseDown != null ) mouseDown()
			if( autoHide ) hide()
		}


	}
	
}

