package rageo.components.button 
{
	include "../index.as"

	public class CheckBox 
	{
		
		private var target 		: MovieClip
		private var m_check 	: Boolean
		
		
		public var onChange 	: Function
		public var mouseOver 	: Function 
		public var mouseOut 	: Function
		
		public function set check( value:Boolean ) 
		{
			m_check 	= 	value
			m_check  	?	Tweenr.fadeIn( target.check ) : Tweenr.fadeOut( target.check )
		}
		
		public function get check() 
		{
			return m_check
		}
		
		public function CheckBox( target:MovieClip, onChange:Function = null, check:Boolean = true,mouseOver:Function=null, mouseOut:Function=null ) 
		{
			this.target 		=	target
			this.onChange 		=	onChange
			this.check 			=	check
			this.mouseOver 		=	mouseOver
			this.mouseOut 		=	mouseOut

			Button.pull({ target:target.button_btn, mouseDown:mouseDown, mouseOver:_mouseOver, mouseOut:_mouseOut })
		}
		
		private function _mouseOver() 
		{
			if( mouseOver != null ) mouseOver()
		}
		
		private function _mouseOut() 
		{
			if( mouseOut != null ) mouseOut()
		}

		public function mouseDown() 
		{
			check = !check
			onChange( check )
		}
		
		
		
	}
	
}