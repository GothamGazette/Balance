package rageo.components.button
{
	include "../index.as"
	
	public class Button extends MCWrapper
	{
		
		/*-------------------------------------------------------------
	
		STATIC //
		
		--------------------------------------------------------------*/
		
		public static var groups		: Object = MCWrapper.groups
		
		public static function pull( params ) 
		{ 
			return new Button( params ) 
		}

		public static function search( target, params ) 
		{
			var list 	=	doSearch( target )

			for ( var n in list ) 
			{
				params.target = list[n]
				params.params = list[n].name.split("_btn")[0]
				Button.pull( params )
			}
		}

		public static function doSearch( target ) 
		{
			var childs 		= 	SpriteUtil.getChilds( target )
			var results 	=	[]
			
			for ( var n in childs ) {
				
				var item = childs[n]
				
				if ( item is SimpleButton ) {
					results.push( item )
					continue
				}
				if ( item is MovieClip ) {
					item.name.toLowerCase().indexOf( "_btn" ) != -1 	?	results.push( item ) : results.concat( doSearch( item ) )
					continue
				}
			}
			return results
		}

		public static function pullSimple( target, mouseDown, params = null ) 
		{
			return new Button( { target:target, mouseDown:mouseDown, params:params } )	
		}

		public static function setButtons( container , func, params = null ) 
		{
			var output = []
			var contained = SpriteUtil.getChilds( container )
			for (var n in contained) { output.push( pullSimple( contained[n], func, params ) )}
			return output
		}
	
		
		
		public static function onSelect( button ) 
		{
			var group 			= 	groups[ button.group ]
			group.selected 		&& 	group.selected != button && button.unique ? group.selected.deSelect() : null
			group.selected 		= 	button
		}
		
		
		
		/*-------------------------------------------------------------
	
		INSTANCE //
		
		--------------------------------------------------------------*/
		
		 
		 
		public var unique 				: Boolean 
		public var selectable 			: Boolean 
		public var isOver 				: Boolean
		public var isDown 				: Boolean
		public var onOff				: Boolean
		public var draggable 			: Boolean
		public var lastClick			: Number = 0 
		
		public var mute 				: Boolean = true
		public var downSound 			= "DownSound"
		public var overSound 			= "OverSound"
			
		public var enabled 				: Boolean = true
		
		public var mouseUp 				: Function = function(){}
		public var mouseDown 			: Function = function(){}
		public var mouseOver 			: Function = function(){}
		public var mouseOut 			: Function = function(){}
		public var click				: Function = function(){}
		public var doubleClick			: Function = function(){}
		public var dragBounds			: Bounds
		public var globalParent			
		public var myParent 			
		public var loader 	
		public var thumbnailFile		
		public var thumbnail 			: String	
		
		public var offset 				: Point = new Point()
		public var params 				: Object
		
		public function Button( params ) 
		{

			group 	=	"buttons"
			
			super( params )
			
			myParent 						=	target.parent
			
			target.addEventListener( MouseEvent.MOUSE_DOWN, _mouseDown )
			target.addEventListener( MouseEvent.MOUSE_OVER, _mouseOver )
			target.addEventListener( MouseEvent.MOUSE_OUT, _mouseOut )

			labelFrame.Up					= 	Utils.or( labelFrame.Up, labelFrame.OverIn || 1 )
			labelFrame.Over					= 	Utils.or( labelFrame.Over, 2 )
			labelFrame.Down					= 	Utils.or( labelFrame.Down, 3 )
			labelFrame.Selected				= 	Utils.or( labelFrame.Selected, labelFrame.OverIn ? labelFrame.Down : 4 )
			labelFrame.OverIn				= 	Utils.or( labelFrame.OverIn, labelFrame.Over )
			labelFrame.OverOut				= 	Utils.or( labelFrame.OverOut, labelFrame.Up )
			
			if ( target is SimpleButton )	{ return }

			labelFrame.loopFrame			=	labelFrame.OverOut ? Utils.or( labelFrame.Outro, target.totalFrames ) : null
			!labelFrame.Intro 				? 	target.gotoAndStop( labelFrame.Up ) : null

			target.buttonMode 			= 	true
			target.mouseChildren 		=	false

			change_thumbnail()
		}


		/*-------------------------------------------------------------
	
		INTERNALS //
		
		--------------------------------------------------------------*/

		private function _mouseOver(e = null) 
		{
			if ( blocked || selected || isDown) { return }

			!mute 		?	SoundManager.playFX( overSound ) : null
			isOver 		= 	true
			goto			( labelFrame.OverIn )
		
			mouseOver()
			
		}

		private function _mouseDown(e = null) 
		{
			if ( blocked ) { return }
			
			
			myParent		=	target.parent
			isDown 			= 	true
			selectable		?	selected && onOff ? deSelect() : !selected ? select() : null : null
			!mute 			?	SoundManager.playFX( downSound ) : null
			params 			? 	mouseDown( params ) : mouseDown()
			
			goto( labelFrame.Down )

			Input.add( _mouseUp, "mouseUp" )
			
			if ( !draggable ) { return }
			
			offset.x		=	target.x - target.parent.mouseX
			offset.y		=	target.y - target.parent.mouseY	

			globalParent	?	globalParent.addChild( target )	 : null

			Cycle.add( _drag )
			_drag()
		}

		private function _mouseOut(e = null) 
		{
			isOver 		=	false
			
			if ( blocked || isDown || selected ) { return }

			goto( labelFrame.OverOut )
			mouseOut()
		}

		private function _mouseUp() 
		{

			if( globalParent )
			{ 
				myParent.addChild( target )
				_drag()
			}

			isDown 	=	false
			
			goto( selected ? labelFrame.Selected : isOver ? labelFrame.Over :  isDown ? labelFrame.Down : labelFrame.OverOut )
			
			_click()
			
			Cycle.remove( _drag )
			Input.remove( _mouseUp, "mouseUp" )
			mouseUp()
		}

		private function _drag() 
		{
			target.x 	= 	target.parent.mouseX 	+ 	offset.x 
			target.y 	= 	target.parent.mouseY 	+ 	offset.y
			
			dragBounds 	?	dragBounds.constrain( target ) : null
		}

		private function _click() 
		{
			if (!isOver ) { return }
			params ? click( params ) : click()
			if( lastClick - (lastClick = getTimer()) + 500 < 0){ return }
			doubleClick != null ? params ? doubleClick( params ) : doubleClick() : null
		}

		
		
		
		/*-------------------------------------------------------------
	
		UPDATE //
		
		--------------------------------------------------------------*/

		override public function goto( frame ) 
		{
			if ( target is SimpleButton ) { return }
			target.gotoAndPlay( frame )
			playing = true
			Cycle.add( update , true )
		}

		public function update() 
		{

			switch ( currentFrame ) 
			{
				case labelFrame.loopFrame : 
					target.gotoAndPlay( labelFrame.Up )
				case labelFrame.Up : 
					isOver || selected ? target.gotoAndPlay( labelFrame.OverIn ) : stop()
					break
				case labelFrame.Over : 
					!isOver && !selected ? target.gotoAndPlay( labelFrame.OverOut ) : stop()
					break
				case labelFrame.Down : 
					!isDown ? target.gotoAndPlay( labelFrame.OverOut ) : stop()
					break
				case labelFrame.Selected : 
					!selected ? target.gotoAndPlay( labelFrame.OverOut ) : stop()
					break
			}
			
			playing 	? 	target.nextFrame() : Cycle.remove( update )	
			
		}
		
		/*-------------------------------------------------------------
	
		EXTERNAL //
		
		--------------------------------------------------------------*/

		
		public function enable() 
		{
			if ( enabled ) { return }
			enabled		=	true
			alpha 		= 	1
			unBlock()
		}
		
		public function disable() 
		{
			if ( !enabled ) { return }
			enabled		=	false
			alpha 		= 	.5
			block()
		}

		public function block() 
		{
			if (isOver) {
				isOver = false
				goto( labelFrame.Up )
			}
			
			isOver 				= 	false
		//	target.blocked		?	target.blocked.visible = true : null
			target.buttonMode 	= 	false
			blocked 			= 	true
		}

		public function unBlock() 
		{
		//	target.blocked		?	target.blocked.visible = false : null
			target.buttonMode 	= 	true
			blocked 			= 	false
			
		}

		public function select() 
		{
			!isDown && !selected? _mouseDown() : null;
			selected 	= 	true
			onSelect( this )
		}

		public function deSelect() 
		{
			if (!selected){ return }
			selected 	= 	false
			_mouseOut()
		}
		
		public function refresh( params = null ) 
		{
			params 		? 	ArrayUtil.extract( params, this ) : null
			change_thumbnail()
		}
		
		public function change_thumbnail() 
		{
			if ( !(target is MovieClip) ) { return }
			if ( !thumbnail|| !Object(target)["thumbnail"]  )	{ return }
		
			SpriteUtil.removeChild( thumbnailFile )
		//	Library.load({ uri:params.thumbnail, container:target.thumbnail, onResult:onThumbnail, fitArea:target.thumbnail.area  })	
		}
		
		public function onThumbnail( thumb ) 
		{
			thumbnailFile 			= thumb
			thumbnailFile.alpha 	= 0
			Tweenr.fadeIn( thumbnailFile )
		}
		
	}	
}
