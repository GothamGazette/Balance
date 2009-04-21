package project 
{	
	import rageo.components.button.CheckBox;
	include "index.as"

	public class RevenuesItem extends MovieClip
	{
		public static var index 		: Array = []
		public static var sum 			: Number
		public static var textField 	: TextField
		public static var deficitField 	: TextField
		public static var msgBox 		: MsgBox
		public static var min 			: Number = 0
		public static var max 			: Number = 100
		public static var originalSum 	: Number = 0
		
		public static function getSum() 
		{
			sum 								= 	Memory.config.RevenuesPage.baseIncome
			for ( var n in index) sum 			+= 	index[n].value
			textField.htmlText 					= 	StringUtil.toDollars( sum )

			if ( Memory.global.current )
			{
				Memory.global.current.revenues 	= 	sum
				Memory.global.current.deficit 	=	Memory.global.current.revenues - Memory.global.current.expendings
				deficitField.text 				=	StringUtil.toDollars( Memory.global.current.deficit  )
			}

			return sum
		}
		
		public static function reset() 
		{
			for ( var n in index) index[n].reset()
		}
		
		public static function getArray() 
		{
			var object = {}
			for ( var n in index ) object[ index[n].data.title ] = index[n].value
			return StringUtil.toPHPArray( object )
		}
		
		public var data 
		public var _value 		: Number
		public var initialized 	: Boolean
		public var checkBox		: CheckBox
		public var checked 		: Boolean
		
		public function RevenuesItem( data )
		{
			this.data 			= 	data
			title.htmlText 		=	data.title
			
			data.check 			=	Boolean(Number(data.check))
			value 				= 	data.check ? Number(data.value) : 0
			
			index.push( this )
			
			Button.pull( { target:more_btn, mouseOver:mouseOver, mouseOut:mouseOut, mouseDown:mouseDown } )
			
			checkBox 			=	new CheckBox( checkBoxMC, onChange, false, mouseOver, mouseOut )
			valueField.text 	= 	StringUtil.toDollars( data.value )
			
			reset()
			
			initialized = true
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
		
		public function onChange( val:Boolean ) 
		{
			checked	= val

			if ( checked && !initialized ) 
			{
				msgBox.showAlert( data.alert )
			}
			
			if(!checked) msgBox.showTip( data.tip )

			value 		= 	checked ? Number(data.value) : 0
			getSum()
		}
		
		public function reset() 
		{
			initialized 			= 	false
			checkBox.check 		=	data.check
			onChange( data.check )
		}
		
		public function set value( amount:Number ) 
		{
			_value 				= 	amount
		}

		public function get value () 
		{
			return _value
		}

	}	
}
