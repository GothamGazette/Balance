package rageo.util
{	
	include "../index.as"
	
	public class GraphicUtil {
		
		public static var colorTransform		: ColorTransform =  new ColorTransform()
		public static var glowFilter 			: GlowFilter = new GlowFilter()
		public static var IDMatrix				: Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0]
		public static var R						: Number = 0.212671
		public static var G						: Number = 0.715160
		public static var B						: Number = 0.072169


		// DRAW AREA
		public static function drawArea( width, height ) 
		{	
			var area = new Sprite()
			
			drawRect( area.graphics, width, height )
		//	target.addChild( area )
			
			return area
		}	
		
		// DRAW RECT
		public static function drawRect( graphics, width=100, height=100, color = 0x000000, alpha = 0 ) 
		{	
			graphics.clear()
			graphics.beginFill(color,alpha)
			graphics.drawRect(0, 0, width, height)
			graphics.endFill()

		}	
		
		// DRAW ROUND RECT
		public static function drawRoundRect( graphics, width, height, round=22, color = 0x000000, alpha = 1 ) 
		{	
			graphics.clear()
			graphics.beginFill( color, alpha )
			graphics.drawRoundRect( 0, 0, width, height, round, round )
			graphics.endFill()
		}
		

		
		// DRAW GRID
		public static function drawGrid( target, width = 100, height = 100, margin = 10, color = null, backColor = null )
		{
			var graphics	=	target.graphics
			
			graphics.clear()
			graphics.lineStyle(0, color)
			
			if (backColor){
				graphics.beginFill(backColor)
				graphics.drawRect(0,0,width,height)
				graphics.endFill()
			}

			for (var x:int = 0; x<=width; x+= margin) {
				graphics.moveTo(x, 0)
				graphics.lineTo(x,height)
			}
			
			for (var y:int = 0; y<=height; y+= margin) {	
				graphics.moveTo(0, y)
				graphics.lineTo(width,y)
			}
		}
		
		// DRAW MAP
		public static function drawMap( target, data, unit )
		{
			var graphics	=	target.graphics
			var color 		=	0xFFFFFF
			
			graphics.clear()
			
			/*
			graphics.beginFill(0x000000)
			graphics.drawRect(0,0,640,480)
			graphics.endFill()
			*/
			
			graphics.beginFill(0xFFFFFF)
			
			for (var n in data){
				
				var pixel = data[n]
				graphics.drawRect(pixel.x*unit, pixel.y*unit, unit, unit )
				
			}
			graphics.endFill()
		}
		
		// HEX TO RGB
		public static function HEXtoRGB(n:Number) 
		{
			return {rb:n >> 16, gb:(n >> 8) & 0xff, bb:n & 0xff}
		}
		
		// RGB TO HEX
		public static function RGBtoHEX(r, g, b) 
		{
			return (r << 16 | g << 8 | b)
		}
		
		// SET COLOR
		public static function setColor( target, color ) 
		{
			colorTransform.color 				= 	color
			target.transform.colorTransform 	= 	colorTransform
		}
		
		// SET GLOW
		public static function setGlow(target:DisplayObject, color:Number = 0x000000, alpha:Number = 1, blurX:Number = 5, blurY:Number = 5, strength:Number = 4, inner:Boolean = false, knockout:Boolean = false, quality:int = 1 ) 
		{
			glowFilter.color 		= 	color
			glowFilter.alpha 		= 	alpha
			glowFilter.blurX 		= 	blurX
			glowFilter.blurY 		= 	blurY
			glowFilter.strength 	= 	strength
			glowFilter.inner 		= 	inner
			glowFilter.knockout 	= 	knockout
			glowFilter.quality 		= 	quality
			target.filters 			= 	[glowFilter]
		}
		
		// COLORIZE
		public static function colorize($m:Array, $color:Number, $amount:Number = 100):Array 
		{
			if (isNaN($color)) {
				return $m;
			} else if (isNaN($amount)) {
				$amount = 1;
			}
			var r:Number = (($color >> 16) & 0xff) / 255;
			var g:Number = (($color >> 8)  & 0xff) / 255;
			var b:Number = ($color         & 0xff) / 255;
			var inv:Number = 1 - $amount;
			var temp:Array =  [inv + $amount * r * R, $amount * r * G,       $amount * r * B,       0, 0,
							  $amount * g * R,        inv + $amount * g * G, $amount * g * B,       0, 0,
							  $amount * b * R,        $amount * b * G,       inv + $amount * b * B, 0, 0,
							  0, 				         0, 					   0, 					     1, 0];		
			return applyMatrix(temp, $m);
		}
		
		// SET THRESHOLD
		public static function setThreshold($m:Array, $n:Number):Array 
		{
			if (isNaN($n)) {
				return $m;
			}
			var temp:Array = [R * 256, G * 256, B * 256, 0,  -256 * $n, 
						R * 256, G * 256, B * 256, 0,  -256 * $n, 
						R * 256, G * 256, B * 256, 0,  -256 * $n, 
						0,           0,           0,           1,  0]; 
			return applyMatrix(temp, $m);
		}
		
		// SET HUE
		public static function setHue($m:Array, $n:Number):Array 
		{
			if (isNaN($n)) {
				return $m;
			}
			$n *= Math.PI / 180;
			var c:Number = Math.cos($n);
			var s:Number = Math.sin($n);
			var temp:Array = [(R + (c * (1 - R))) + (s * (-R)), (G + (c * (-G))) + (s * (-G)), (B + (c * (-B))) + (s * (1 - B)), 0, 0, (R + (c * (-R))) + (s * 0.143), (G + (c * (1 - G))) + (s * 0.14), (B + (c * (-B))) + (s * -0.283), 0, 0, (R + (c * (-R))) + (s * (-(1 - R))), (G + (c * (-G))) + (s * G), (B + (c * (1 - B))) + (s * B), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
			return applyMatrix(temp, $m);
		}
		
		// SET BRIGHTNESS
		public static function setBrightness($m:Array, $n:Number):Array 
		{
			if (isNaN($n)) {
				return $m;
			}
			$n = ($n * 100) - 100;
			return applyMatrix([1,0,0,0,$n,
								0,1,0,0,$n,
								0,0,1,0,$n,
								0,0,0,1,0,
								0,0,0,0,1], $m);
		}
		
		// SET SATURATION
		public static function setSaturation($m:Array, $n:Number):Array 
		{
			if (isNaN($n)) {
				return $m;
			}
			var inv:Number = 1 - $n;
			var r:Number = inv * R;
			var g:Number = inv * G;
			var b:Number = inv * B;
			var temp:Array = [r + $n, g     , b     , 0, 0,
							  r     , g + $n, b     , 0, 0,
							  r     , g     , b + $n, 0, 0,
							  0     , 0     , 0     , 1, 0];
			return applyMatrix(temp, $m);
		}
		
		// SET CONTRAST
		public static function setContrast($m:Array, $n:Number):Array 
		{
			if (isNaN($n)) {
				return $m;
			}
			$n += 0.01;
			var temp:Array =  [$n,0,0,0,128 * (1 - $n),
							   0,$n,0,0,128 * (1 - $n),
							   0,0,$n,0,128 * (1 - $n),
							   0,0,0,1,0];
			return applyMatrix(temp, $m);
		}
		
		// APPLY MATRIX
		public static function applyMatrix($m:Array, $m2:Array):Array 
		{
			if (!($m is Array) || !($m2 is Array)) {
				return $m2;
			}
			var temp:Array = [];
			var i:int = 0;
			var z:int = 0;
			var y:int, x:int;
			for (y = 0; y < 4; y++) {
				for (x = 0; x < 5; x++) {
					if (x == 4) {
						z = $m[i + 4];
					} else {
						z = 0;
					}
					temp[i + x] = $m[i]   * $m2[x]      + 
								  $m[i+1] * $m2[x + 5]  + 
								  $m[i+2] * $m2[x + 10] + 
								  $m[i+3] * $m2[x + 15] +
								  z;
				}
				i += 5;
			}
			return temp;
		}

		
		
	}
}
