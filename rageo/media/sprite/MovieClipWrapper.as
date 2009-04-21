
package gna.system.media
{
	import flash.display.*
	import flash.utils.*
	import flash.text.*
	import flash.geom.*

	import gna.system.*
	import gna.utils.*
	import gna.uicomponents.*
	
	public class MovieClipWrapper
	{
		
		public var target			: MovieClip
		public var z				: Number = 0
		public var playing			: Boolean
		
		public var labels 			: Object = {}
		public var labelFrame		: Array
		public var label			: String
		public var timeline			: Array
		public var totalTimeline 	: Array
		public var frame 			: Number
		public var lastFrame 		: uint = 0 
		public var loop				: int
		public var onReach 			: Function
		public var velocity			: Number = -1
		
		public function MovieClipWrapper( target:MovieClip )
		{
			this.target = target
			
			totalTimeline 			=	SpriteUtil.getTimeline( target )
			timeline 				= 	totalTimeline
			labels 					= 	totalTimeline.labels
			lastFrame 				=	totalTimeline.length - 1
			frame 					=	0

			target.gotoAndStop(1)
		}
		
		/* control */
		
		public function show() 
		{
			visible = true
		}
		
		public function hide() 
		{
			gotoAndStop( 0 )
			target.visible = false
		}
		
		public function random( n:uint = 0 )
		{
			frame =	MathUtil.random( n || lastFrame )
		}
		
		public function play() 
		{
			show()
			playing = true
			Cycle.add( nextFrame )
		}
		
		public function nextFrame() 
		{
			if(!playing) return
			
			frame += velocity
			
			if ( (frame > lastFrame || frame < 0) && lastFrame > 0 )
			{
				if ( loop > 0 )
				{
					while ( frame > lastFrame && loop > 0 ) { frame -= lastFrame; loop-- }
					while ( frame < 0 && loop > 0 ) { frame += lastFrame; loop-- }
				}
				else if ( loop == -1 )
				{
					while ( frame > lastFrame ) frame -= lastFrame
					while ( frame < 0 ) frame += lastFrame
				}
			}
			
			if ( frame > lastFrame ) frame == lastFrame
			if ( frame < 0 ) frame = 0
			
			if ( frame <= 0 || frame >= lastFrame )
			{				
				stop()
				
				if ( loop == 0 ) onReach != null ? onReach() : null
			}
			
			target.gotoAndStop( timeline[ int(frame) ] )	
		}

		public function stop() 
		{ 
			playing = false
			target.stop() 
			Cycle.remove( nextFrame )
		}
		
		public function gotoLabel( label:String, loop:int = -1, onReach:Function = null )
		{
			gotoAndPlay( 0, label, loop, onReach )
		}
		
		public function gotoAndPlay( frame:Number, label:String = null, loop:int = -1, onReach:Function = null ) 
		{
			this.onReach		= 	onReach
			this.loop 			= 	loop
			this.frame 			= 	frame
			this.label 			= 	labels[label] ? label : null
			timeline 			= 	this.label ? labels[ this.label ] : totalTimeline
			lastFrame 			=	timeline.length - 1
			target.gotoAndStop( timeline[ int(frame)  ] )
			play()
		}
		
		public function gotoAndStop( frame:Number, label:String = null ) 
		{
			this.frame 			= 	frame
			this.label 			= 	labels[label] ? label : null
			timeline 			= 	this.label ? labels[ this.label ] : totalTimeline
			lastFrame 			=	timeline.length - 1
			target.gotoAndStop( timeline[ int(frame) ] )
			stop()
		}
		
		public function set backwards( val:Boolean ) { velocity = (val ? 1 : -1) * Math.abs( velocity ) }		
		public function get backwards():Boolean { return velocity > 0 ? false : true }

		/* get y sets */
		
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
		
		public function set parent( value:DisplayObjectContainer ){ value.addChild( target ) }
		public function get parent(){ return target.parent }
		
		public function addChild(child){ target.addChild(child); return child }
		public function removeChild(child){ target.removeChild(child); return child }
		
		public function get currentLabel() 	{ return target.currentLabel }
		public function get currentFrame() 	{ return target.currentFrame }
		public function get totalFrames()	{ return target.totalFrames }
	}
}

