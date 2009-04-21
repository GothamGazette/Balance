package rageo.util
{	
	include "../index.as"
	
	public class FiltersUtil
	{		
		public static function gray( val:Number = 1, toR:Number = 0.212671, toG:Number = 0.715160, toB:Number = 0.072169, offsetR:Number = 0, offsetG:Number = 0, offsetB:Number = 0, out:ColorMatrixFilter = null ):ColorMatrixFilter
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
				
			if ( out == null ) out = new ColorMatrixFilter()
			
			out.matrix = array
				
			return out
		}		
	}	
}