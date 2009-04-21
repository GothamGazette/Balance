package rageo.util
{	
	include "../index.as"
	
	public class SpriteUtil 
	{		
		
		public static function flip( target, positive ) 
		{
			var sX : Number 	= 	MathUtil.positive( target.scaleX )
			target.scaleX 		= 	positive > 0 ?  sX : - sX	
		}
		
		public static function flashvar(displayObject:DisplayObject, value:String):String
		{
			if(displayObject.loaderInfo.parameters[value])
				return displayObject.loaderInfo.parameters[value];
				
			return displayObject.parent ? flashvar(displayObject.parent, value) : null;
			
		}
		
		public static function localToLocal( target, space )
		{
			return space.globalToLocal(target.localToGlobal(new Point()))	
		}
		
		/*----------------------------
		
			TIMELINE
			
		------------------------------*/
		
		public static function goPercent( target, percent, autoHide = true ) 
		{
			if( !target ){ return }
			target.gotoAndStop( MathUtil.getPercent(percent, 100, target.totalFrames, null, null, false) )
			target.visible 	=	!autoHide || ( percent > 0 && percent < 100 )
		}

		public static function random( target )
		{
			if ( !target ) { return }
			target.gotoAndStop( Math.round( MathUtil.random( target.totalFrames-1, 1 )))
		}
		
		public static function getLabels( target ) 
		{
			if ( !(target is MovieClip) ) { return [] }
			
			var labels					= 	[]
			var la						= 	target.currentScene.labels

			for (var n in la) {
				labels[ la[n].name ] 	=	la[n].frame
			}	
			return labels
		}

		public static function getTimeline( movieclip, bitmapFill:Boolean = false ) 
		{		
			var timeline 			=	[]
			var arrayLabels 		=	getLabels( movieclip )
			var arrayTimeline 		=	ArrayUtil.toInverse( arrayLabels )
			var totalFrames 		=	movieclip.totalFrames
			var labels				=	{}
			var label
			var lastLabel 
			var bmp
			
			timeline.width 			=	movieclip.width
			timeline.height 		=	movieclip.height
			
			if ( bitmapFill )
			{
				bmp					= 	new BitmapData( movieclip.width, movieclip.height, true, 0x00000000 )
				bmp.draw( movieclip )
			}
			
			for (var n = 0; n < totalFrames ; n++ ) 
			{ 	
				timeline.push( bmp || n+1 ) 
				label	=	arrayTimeline[n + 1] || lastLabel

				if ( label ) {
					!labels[label] ? labels[label] = [] : null
					lastLabel = label
					labels[label].push( bmp || n+1 )
				}
			}
			//for (n in labels){labels[ n ].frame	=	arrayLabels[n]}	
			timeline.labels = labels
			return timeline
		}
		
		/*----------------------------
		
			CHILDS
			
		------------------------------*/

		public static function getChilds( target ):Array 
		{
			var results=[]
			for (var n=0;n<target.numChildren;n++){
				results.push(target.getChildAt(n))
			}
			return results
		}
		
		public static function getFirstChild( target ) 
		{
			return target.getChildAt(0)
		}

		public static function removeChilds( target )
		{
			while (target.numChildren){
				removeChild( target.getChildAt(0) )
			}
		}

		public static function removeChild( target = null ) 
		{
			if (target is DisplayObject && target.parent )
			{
				if (target.parent is Loader) return
				target.parent.removeChild(target)
			}
		}

		/*----------------------------
		
			DEPTH
			
		------------------------------*/
		
		public static function toFront( target=null, container = null )
		{
			if( !(target is DisplayObject ) ){ return }
			container ? container.addChild(target) : container = target.parent
			container.setChildIndex( target, container.numChildren-1 )
		}

		public static function toBack( target, container = null )
		{
			container ? container.addChild(target) : null
			target.parent.setChildIndex(target, 0);
		}

		public static function sort( target, property = "z", descending = true ) 
		{
			var array 	= 	target is Array ? ArrayUtil.copyRows( target ) : SpriteUtil.getChilds( target )
			array		=	ArrayUtil.sort( array, property, descending )
			
			for ( var n in array ) {
				array[n].parent.setChildIndex( array[n], n )
			}
			return array
		}

		/*----------------------------
		
			ALIGN
				
		------------------------------*/
		
		public static function selfCenter(target)		
		{
			target.x = -target.width/2
			target.y = -target.height/2
		}
		
		
		public static function fit(target, fitArea, crop = false) 
		{
			var a 			= 	fitArea
			var t  			= 	target
			var rad
			rad 			= 	a.width/t.width;
			target.width 	*= 	rad, target.height *= rad
			rad 			= 	a.height/t.height;
			
			if ((crop && t.height<a.height) || (!crop && t.height>a.height) ) 
			{
				t.width 	*= 	rad
				t.height 	*= 	rad
			}
			center(target, fitArea)
		}

		public static function center(target, area) 
		{
			target.y 		=	area.y	+  (area.height - target.height)/2
			target.x 		= 	area.x	+  (area.width  - target.width)/2
		}

		public static function toColumns( list, marginX = 5, marginY = 5, columns = 1, horizontal = false ) 
		{
			var large 		= 0
			var short 		= 0
			var rect		= new Rectangle(0,0,0,0)
			
			var item, width, height, preItem, p_width, p_height
			
			for (var n = 0; n<list.length; n++) {
				
				item 			= list[n]
				width 			= item.width
				height 			= item.height
				
				preItem 		= list[n-columns] || rect
				p_width 		= preItem.width
				p_height		= preItem.height
 	
				item.x 			= horizontal ? preItem.x+p_width+marginX 	: (width + marginX)*short
				item.y 			= horizontal ? (height + marginY)*short 	: preItem.y+p_height+marginY
  
				++short >= columns ? (short = 0, large++) : null
				
			}
		}
		
		public static function constrainOverflow( target, rect, margin:int = 0) 
		{
			var minx	=	rect.x + rect.width - margin - target.width
			var maxx	=	rect.x + margin
			var miny	=	rect.y + rect.height - margin - target.height
			var maxy	=	rect.y + margin
			var x 		= 	target.x
			var y 		= 	target.y

			target.x 	=	target.width > rect.width ? MathUtil.constrain ( x, minx , maxx) : MathUtil.constrain ( x, maxx , minx )
			target.y	=	target.height > rect.height ? MathUtil.constrain ( y, miny , maxy) : MathUtil.constrain ( y, maxy , miny )
		}
		
		/*----------------------------
		
			FIELDS
			
		------------------------------*/
		
		public static function fillFields( target:MovieClip, data:Object = null ) 
		{
			if (!data) return
			
			for ( var n in data) 
			{
				var field = target[n]
				var value = data[n]

				if ( field ) 
				{
					
					if ( value is Array ) 
					{
						if ( field is MovieClip ) fillFields( field, value )
						
					}else {
						if ( field is MovieClip ) 
						{
							if( field.textField ) field.textField.htmlText= value
						}
						if( field is TextField ) field.htmlText= value
					}
				}
			}
		}
		
		
	}
}