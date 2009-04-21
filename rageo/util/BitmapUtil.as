package rageo.util
{	
	include "../index.as"
	
	public class BitmapUtil
	{		
		private static var pointZero:Point = new Point( 0, 0 )
		
		private static var matrix:Array = new Array()
		
		private static var colorMatrix:ColorMatrixFilter = new ColorMatrixFilter()
		
		private static var blurFilter:BlurFilter = new BlurFilter()
		
		
		public static function fromMovieClip( mc:MovieClip, transparent:Boolean = false, fillColor:int = 0x000000, outBounds:Rectangle = null ):BitmapData
		{
			var bounds:Rectangle = mc.getRect(mc)
			
			var bmp:BitmapData = new BitmapData( bounds.width, bounds.height, transparent, fillColor )
			
			var matrix:Matrix = new Matrix( 1, 0, 0, 1, -bounds.x, -bounds.y )
			
			bmp.draw( mc, matrix )
			
			if ( outBounds )
			{
				outBounds.x = bounds.x
				outBounds.y = bounds.y
				outBounds.width = bounds.width
				outBounds.height = bounds.height
			}
			
			return bmp
		}
		
		public static function fromCroppedMovieClip( mc:MovieClip, transparent:Boolean = false, fillColor:int = 0x000000, outBounds:Rectangle = null, maskColor:int = 0x00000000 ):BitmapData
		{
			var bounds:Rectangle = mc.getRect( mc )
			
			var src:BitmapData = fromMovieClip( mc, true )
			
			var rect:Rectangle = src.getColorBoundsRect( 0xffffffff, maskColor, false )
			
			var bmp:BitmapData = new BitmapData( rect.width, rect.height, transparent, fillColor )
			
			var matrix:Matrix = new Matrix( 1, 0, 0, 1, -rect.x, -rect.y )
			
			bmp.draw( src, matrix )
			
			outBounds.x = rect.x + bounds.x
			outBounds.y = rect.y + bounds.y
			outBounds.width = rect.width
			outBounds.height = rect.height
			
			src.dispose()
			
			return bmp
		}
		
		public static function gray( src:BitmapData, out:BitmapData, val:Number = 1, toR:Number = 0.212671, toG:Number = 0.715160, toB:Number = 0.072169, offsetR:Number = 0, offsetG:Number = 0, offsetB:Number = 0 )
		{
			var r:Number = 1 - val * (1 - toR)
			var g:Number = 1 - val * (1 - toG)
			var b:Number = 1 - val * (1 - toB)
			
			var array:Array = new Array()
			
				array[0] = r
				array[1] = g * val
				array[2] = b * val
				array[3] = 0
				array[4] = offsetR * val
				
				array[5] = r * val
				array[6] = g
				array[7] = b * val
				array[8] = 0
				array[9] = offsetG * val
				
				array[10] = r * val
				array[11] = g * val
				array[12] = b
				array[13] = 0
				array[14] = offsetB * val
				
				array[15] = 0
				array[16] = 0
				array[17] = 0
				array[18] = 1
				array[19] = 0
				
			colorMatrix.matrix = array
			
			out.applyFilter( src, src.rect, pointZero, colorMatrix )
		}
		
		public static function blur( src:BitmapData, out:BitmapData, blurX:Number = 4, blurY:Number = 4, quality:Number = 1 )
		{
			blurFilter.blurX = blurX
			blurFilter.blurY = blurY
			blurFilter.quality = quality
			
			out.applyFilter( src, src.rect, pointZero, blurFilter )
		}
		
	}
	
}