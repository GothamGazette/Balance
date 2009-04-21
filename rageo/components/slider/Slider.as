package rageo.components.slider 
{
	include "../index.as"

	public class Slider 
	{
		public var horizontal 		: Boolean = false
		public var bounds 			: Bounds 
		public var position 		: Number = 0
		public var manual 			: Boolean
		public var onChange 		: Function = function(p=null) {}
		public var onStop	 		: Function = function(p=null) {}
		public var target 			: MovieClip 
		public var mode 			: String
		public var blocked 			: Boolean 
		
		// CONSTRUCT
		public function Slider( target:MovieClip, onChange:Function = null  ) 
		{
			this.target 		=	target
			this.onChange 		=	onChange || this.onChange
			horizontal 			=	target.width > target.height
			
			var b				=	target.bar_btn
			var s				=	target.slider_btn
			bounds 				=	horizontal 	?	new Bounds( b.y, b.y, b.x, b.x + b.width - s.width ) : new Bounds( b.y, b.y + b.height - s.height, b.x, b.x )

			bounds.right 		=	b.width - s.width
			bounds.bottom 		=	b.height - s.height
			
			Button.pull({ target:s, 	mouseDown:mouseDown, mouseUp:mouseUp, params:"slider", draggable:true, dragBounds:bounds }) 
			Button.pull({ target:b, 	mouseDown:mouseDown, mouseUp:mouseUp, params:"bar" }) 
			
			if( target.plus_btn	)		Button.pull({ target:target.plus_btn,		mouseDown:mouseDown, 	mouseUp:mouseUp, params:"plus" })
			if( target.minus_btn ) 		Button.pull({ target:target.minus_btn, 		mouseDown:mouseDown, 	mouseUp:mouseUp, params:"minus" }) 
			
		//	step()
		}
		
		private function mouseDown( mode:String ) 
		{
			this.mode = mode
			Cycle.add( step )
			step()
		}

		private function step() 
		{

			if ( mode == "minus" )
			{
				position 		-= .3
			}
			
			if ( mode == "plus" )
			{
				position 		+= .3
			}
			
			if ( mode == "bar" )
			{
				var pos 		=	horizontal ? (target.mouseX - bounds.left)*100/bounds.right  :  (target.mouseY - bounds.top)*100/bounds.bottom 
				position 		+= 	( pos - 3 - position ) / 10
			}
			
			manual = false
			
			if ( mode == "slider" )
			{
				manual 					= 	true
				position 				=	horizontal ? (target.slider_btn.x - bounds.left)*100/bounds.right  :  (target.slider_btn.y - bounds.top)*100/bounds.bottom 
			}
			
			position 					=	MathUtil.constrain( position, 0, 100 )
		
			constrainSlider() 
			onChange(position)
		}
		
		public function setPosition( value:Number ) 
		{
			position  = value
			constrainSlider() 
		}
		
		private function constrainSlider() 
		{
			if ( !manual ) {
				target.slider_btn.x	 	=	horizontal 		?	bounds.left + position * bounds.right / 100 : bounds.left
				target.slider_btn.y 	=	!horizontal 	?	bounds.top + position * bounds.bottom / 100 : bounds.top
			}
			
			if ( target.meter ) {
				horizontal  	?	target.meter.x 	=	target.slider_btn.x		:	target.meter.y 	=	target.slider_btn.y
			}
		}
		
		private function mouseUp() 
		{
			manual	=	false
			mode 	=	""
			
			Cycle.remove( step )
			step()
			onStop(position)
		}
		
		public function disable()
		{
			target.alpha 			= 	.5
			target.blocked			?	target.blocked.visible = true : null
			target.mouseChildren 	= 	false
			blocked 				= 	true
		}

		public function enable()
		{
			target.alpha 		= 	1
			target.blocked			?	target.blocked.visible = false : null
			target.mouseChildren 	= 	true
			blocked 				= 	false	
		}
		
		public function show() 
		{
			target.visible 			=	true
		}
		
		public function hide() 
		{
			target.visible 			=	false
		}

	}
}