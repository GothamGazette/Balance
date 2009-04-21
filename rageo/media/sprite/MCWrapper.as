package rageo.media.sprite 
{
	include "../index.as"
	
	public class MCWrapper
	{
		
		public static var groups 	: Object = {}
		public static var pool 		: Array = []

		public var target			
		public var group 			: String = "unsorted"
		public var z				: Number = 0
		public var linkage 	
		public var container		: DisplayObject
		public var blocked 			: Boolean 
		public var selected			: Boolean 
		public var textField 		
		public var format			: TextFormat 
		public var _align			: String = "left"
		public var playing			: Boolean
		
		public var labels 			: Object = {}
		public var labelFrame		: Array
		public var label			: String
		public var timeline			: Array
		public var _timeline 		: Array
		public var frame 			
		public var lastFrame 		: uint = 0 
		public var backwards 		: Boolean
		public var loop				: Boolean
		public var onReach 			: Function

		public function MCWrapper( params )
		{
			ArrayUtil.extract( params, this )

			linkage						?	target = Utils.attach( linkage, container ) : null
			labelFrame					=	SpriteUtil.getLabels( target )
			
			if ( target is MovieClip )
			{
				target.textField 		? 	textField = target.textField : null
				textField && !format	?	format = new TextFormat() : null
				textField				?	textField.setTextFormat( format ) : null
				_timeline 				=	SpriteUtil.getTimeline( target )
				timeline 				= 	_timeline
				labels 					= 	_timeline.labels
				lastFrame 				=	_timeline.length - 1
				frame 					=	0

				target.gotoAndStop(1)
			}
			push ( this )
		}
		
		public function show() 
		{
			visible = true
		}
		
		public function hide( n=null ) 
		{
			n ? gotoAndStop(n) : null
			target.visible = false
		}
		
		public function random( n:uint = 0 )
		{
			frame 				= 	MathUtil.random( n || lastFrame )
		}
		
		public function play(e = null) 
		{
			show()
			playing = true
			Cycle.add( nextFrame )
		}
		
		public function nextFrame() 
		{
			if(!playing) return
			
			frame 		=	MathUtil.cycle( frame, 0, lastFrame, backwards ? -1 : 1, loop )

			if( frame == lastFrame && !loop)
			{
				onReach != null ? onReach() : null
				stop()
			}

			target.gotoAndStop( timeline[ frame ] )	
		}

		public function stop(e = null) 
		{ 
			playing = false
			target.stop() 
			Cycle.remove( nextFrame )
		}
		
		public function goto( params ) 
		{
			ArrayUtil.extract( params, this )
	
			!labels[label] 		?	label = null : null
			timeline 			= 	label && labels[label] ? labels[label] : _timeline
			lastFrame 			=	timeline.length-1
			frame				== 	"random" ? random() : null
			//playing 			?	play() : null
			target.gotoAndStop( timeline[ frame ] )
		}
		
		public function gotoAndPlay(n) 
		{
			frame	= n-1
			target.gotoAndStop(n)
			play()
		}
		
		public function gotoAndStop(n) 
		{ 
			frame	= n-1
			target.gotoAndStop(n)
			stop()
		}
		
		public function set text ( val )
		{
			textField 		? 	textField.text = val : null
		}
		
		public function get text()
		{
			return textField.text
		}
		
		public function set align ( val )
		{
			_align 			= 	val
			format.align 	= 	_align
			textField 		? 	textField.setTextFormat( format ) : null
		}

		public function set autoSize ( val )
		{
			textField.autoSize = val
		}
		
		public function set x(val){ target.x=val }
		public function get x(){ return target.x }
		
		public function set y(val){ target.y=val }
		public function get y(){ return target.y }

		public function set width(val){ target.width=val }
		public function get width(){ return target.width }
		
		public function set height(val){ target.height=val }
		public function get height(){ return target.height }
		
		public function set alpha(val){ target.alpha=val }	
		public function get alpha(){ return target.alpha }
		
		public function set visible(val){ target.visible=val }	
		public function get visible(){ return target.visible }
		
		public function set rotation(val){ target.rotation=val }	
		public function get rotation(){ return target.rotation }
		
		public function set scaleX(val){ target.scaleX=val }	
		public function get scaleX(){ return target.scaleX }
		
		public function set scaleY(val){ target.scaleY=val }	
		public function get scaleY(){ return target.scaleY}
		
		public function get mouseX(){ return target.mouseX }
		public function get mouseY(){ return target.mouseY }
		
		public function get parent(){ return target.parent }
		
		public function addChild(child){ target.addChild(child); return child }
		public function removeChild(child){ target.removeChild(child); return child }
		
		public function get currentLabel() 	{ return target.currentLabel }
		public function get currentFrame() 	{ return target.currentFrame }
		public function get totalFrames()	{ return target.totalFrames }
		
		
		
		/*-------------------------------------------------------------
	
		
		
		
		
		
		CLEAN THIS MESS //
		
		
		
		
		
		
		--------------------------------------------------------------*/
		
		
		
		public static function push ( component )
		{
			var group = component.group
			!groups[ group ] ? groups[ group ] = [] : null
			groups[ group ].push( component )
			pool.push( component )
		}
		
		public static function enableGroup( group = null )
		{
			var list = group ? groups[ group ] :  pool
			for (var n in  list){ list[n].enable() }
		}

		public static function disableGroup( group = null )
		{
			var list = group ? groups[ group ] :  pool
			for (var n in list){ list[n].disable() }
		}

		public static function setInvalidGroup( group = null , txt = null)
		{
			var list = group ? groups[ group ] : pool
			for (var n in list){ list[n].setInvalid(txt) }
		}
		
		public static function failedGroup( group = null , txt = null )
		{
			var list = group ? groups[ group ] : pool
			for (var n in list){ list[n].failed(txt) }	
		}
		

		public static function validateGroup( group = null , forceFail:Boolean = true)
		{
			var list = group ? groups[ group ] : pool
			for (var n in list){ if (!list[n].validate(forceFail)){ return false }}
			return true
		}
		
	}
}

