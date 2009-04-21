package project 
{	
	include "index.as"

	public class SliderItem extends MovieClip
	{
		public static var index 		: Array = []
		public static var sum 			: Number
		public static var textField 	: TextField
		public static var deficitField 	: TextField
		public static var msgBox 		: MsgBox
		public static var min 			: Number = 0
		public static var max 			: Number = 100
		
		public static function getSum() 
		{
			sum 						= 	0
			for ( var n in index) sum 	+= 	index[n].value
			textField.text 				= 	StringUtil.toDollars( sum )
			if ( Memory.global.current ) Memory.global.current.expendings = sum
			
			if ( Memory.global.current )
			{
				Memory.global.current.expendings 	= 	sum
				Memory.global.current.deficit 		=	Memory.global.current.revenues - Memory.global.current.expendings
				deficitField.text 					=	StringUtil.toDollars( Memory.global.current.deficit  )
			}
			
			return sum
		}
		
		public static function reset() 
		{
			for( var n in index) index[n].reset()
		}
		
		public static function getArray() 
		{
			var object = {}
			for ( var n in index ) object[ index[n].data.title ] = index[n].value
			return StringUtil.toPHPArray( object )
		}
		
		public var data 
		public var _value 	: Number
		public var slider 	: Slider 
		public var alerted 	: Boolean
		public var barmax 	: Number

		public function SliderItem( data )
		{
			this.data 		= 	data
			title.htmlText 	=	data.title
			slider 			= 	new Slider( sliderMc, onChange )
			barmax			=	data.value * 2
			
			index.push( this )
			
			Button.pull({ target:more_btn, mouseOver:mouseOver, mouseOut:mouseOut, mouseDown:mouseDown })
			Button.pull({ target:more2_btn, mouseOver:mouseOver, mouseDown:mouseDown })

			reset()
		}
		
		function mouseOver() 
		{
			msgBox.showTip( data.tip )
		}
		
		function mouseDown() 
		{
			mouseOut()
			PageManager.overlay("LearnMorePage")
			LearnMorePage.fill( data )
		}
		
		function mouseOut() 
		{
			msgBox.reset()
		}
		
		public function onChange( val ) 
		{
			var rVAL = val * barmax / 100
			
			if ( !alerted && rVAL < _value) 
			{
				alerted = true
				msgBox.showAlert( data.alert )
			}
			
			if( rVAL > _value ) alerted = false

			value 		= 	rVAL
			getSum()
		}
		
		public function reset() 
		{
			value 		=	Number(data.value)
			alerted 	= 	false
			slider.setPosition( _value * 100 / barmax )
		}
		
		public function set value( amount:Number ) 
		{
			_value 				= amount
			valueField.text 	= StringUtil.toDollars( amount )
		}

		public function get value () 
		{
			return _value
		}

	}	
}
