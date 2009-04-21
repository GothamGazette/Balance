package rageo.media.text 
{
	include "../index.as"

	public class BitmapText extends Sprite 
	{
		
		public static var dictionary 		: Dictionary = new Dictionary()
		public var target					: MovieClip
		public var textField				: TextField
		public var format 					: String // score, time
		public var zeroes 					: int  = 4
		//public var z 						: Number = 0
		public var tweenParams	 			: Object = {}
		public var linkage 					: Object
		public var duration					: int = 1
		public var bitmap 					: Bitmap
		public var bitmapData				: BitmapData
		public var rect						: Rectangle
		public var onComplete 				: Function
		public var transitioning 			: Boolean
		
		public function BitmapText( params:Object ) 
		{

			target 				=	params.target
			linkage 			=	params.linkage
			
			x 					= 	target.x + target.width / 2
			y 					= 	target.y + target.height / 2
			
			if( target.parent) target.parent.addChild( this )
			SpriteUtil.removeChild( target )

			textField			=	target.textField
			bitmapData			=	new BitmapData( target.width, target.height, true, 0x00000000 )
			bitmap				=	new Bitmap( bitmapData, "auto", true )
			rect				=	new Rectangle( 0, 0, target.width, target.height )
			bitmap.x 			= 	- bitmap.width / 2
			bitmap.y 			= 	- bitmap.height / 2
			
			addChild( bitmap )
			
			show()

			ArrayUtil.extract( params, this )
		}
		
		public function show()
		{
			visible 			= 	true
		}
		
		public function hide()
		{
			visible 			= 	false
		}
		
		public function set text ( value ) 
		{
			if ( value == textField.text ) return
			
			var value 		= 	value
			format 			==	"score" ? value = StringUtil.commas( StringUtil.fillZero( value, zeroes ) ) : null
			format 			==	"time" 	? value = StringUtil.seconds2Minutes( value ) : null
			textField.text 	= 	value
			
			bitmapData.lock()
			bitmapData.fillRect( rect, 0x0000FF );
			bitmapData.draw( target, null, null, null, null, true )
			bitmapData.unlock()
		}
		
		public function play ( params:Object ) 
		{
			visible 					= 	true
			
			ArrayUtil.extract( params, this )
			
			tweenParams.onComplete	 	= 	_onComplete
			transitioning				=	true

			Tweenr.to( this, duration, tweenParams )
		}

		private function _onComplete() 
		{
			transitioning = false
			if( onComplete != null ) onComplete()
		}
		
	}

}

