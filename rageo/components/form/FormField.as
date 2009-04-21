
package rageo.components.form 
{
	import flash.display.MovieClip;
	import rageo.components.button.Button;
	
	include "../index.as"
	
	public class FormField
	{
		
		/*-------------------------------------------------------------
	
		
		STATIC //
		
		
		--------------------------------------------------------------*/
		
		public static function search( target ) 
		{
			var fields 				=	{}
			var childs 				= 	SpriteUtil.getChilds( target )

			for ( var n in childs ) 
			{
				var item 			= 	childs[n]
				if ( item is MovieClip && item.name.toLowerCase().indexOf( "_field" ) != -1 ) fields[ item.name.toLowerCase().split("_field")[0] ] = new FormField( childs[n] )
			}
			return fields
		}
		
		

		/*-------------------------------------------------------------
	
		
		INSTANCE //
		
		
		--------------------------------------------------------------*/

		public var target 			: MovieClip
		public var defaultText		: String = ""
		public var defaultError		: String = "INVALID"
		public var required			: Boolean = true
		public var minChars 		: int = 3
		public var maxChars			: int = 0
		public var restrict 		: String 
		public var maxValue 		: int = 0
		public var minValue 		: int = 0
		public var name 			: String

		private var textField 		: TextField
		private var isPassword 		: Boolean
		private var isEmail 		: Boolean
		private var isLogin 		: Boolean
		
		
		public function FormField( target:MovieClip, name:String = null )
		{
	
			this.target 		=	target
			this.name 			=	name || target.name.toLowerCase().split("_field")[0]
			textField			=	target.textField

			// format

			var name 			=	this.name
			
			isPassword 			=	name.indexOf("password") != -1
			isEmail 			=	name.indexOf("email") != -1
			isLogin 			=	name.indexOf("login") != -1 || name.indexOf("username") != -1
			
			if ( isPassword ) 
			{
				restrict 		=	"abcdefghijklmnopqrstuvwxyz_1234567890"
				minChars 		=	6
				maxChars 		=	8
			}
			
			if ( isPassword || isLogin ) 
			{
				restrict 		=	"abcdefghijklmnopqrstuvwxyz_1234567890"
				minChars 		=	2
				maxChars 		=	16
			}
			
			if ( isEmail ) {
				restrict 		=	"abcdefghijklmnopqrstuvwxyz_1234567890.@"
				minChars 		=	5
				maxChars 		=	50
			}

			textField.maxChars 	=	maxChars
			textField.restrict	=	restrict
		}

		public function enable()
		{
			textField.addEventListener( "mouseDown", mouseDown )
			textField.addEventListener( "keyDown", keyDown )
			Input.add( mouseUp, "mouseUp" )
			reset()
		}
		
		public function disable()
		{
			textField.removeEventListener( "mouseDown", mouseDown )
			textField.removeEventListener( "keyDown", keyDown )
			Input.remove( mouseUp, "mouseUp" )
		}
		
		/*-------------------------------------------------------------
	
		MOUSEDOWN //
		
		--------------------------------------------------------------*/
		
		private function mouseDown( e=null )
		{
			text == defaultText || text == defaultError ? text = "" : null
			textField.setSelection( 0, textField.text.length )
			textField.displayAsPassword   = name.indexOf( "password" ) != -1
		}
		
		private function keyDown(e)
		{
			textField.displayAsPassword   = name.indexOf( "password" ) != -1
		}
		
		private function mouseUp()
		{
			!target.hitTestPoint( target.stage.mouseX, target.stage.mouseY, true ) ? validate() : null
		}
		
		/*-------------------------------------------------------------
	
		VALIDATE //
		
		--------------------------------------------------------------*/
		
		public function validate( forceFail:Boolean = false )
		{
			var isValid = true

			if ( text == defaultText || text == defaultError  )
			{
				isValid = false
				forceFail ? failed() : null
				return false
			}

			if ( text.length < minChars )
			{
				forceFail ? failed() : reset()
				return false
			}

			if (isEmail && !StringUtil.validateEmail(text))
			{
				forceFail ? failed() : reset()
				text	=	defaultError
				return false
			}
			
			if ( text is Number && maxValue != 0 &&  Number(text) > maxValue) 
			{
				isValid 	= 	false
				text	=	defaultError
				forceFail ? failed() : null
				return false
			}
			
			if ( text is Number && minValue != 0 &&  Number(text) < minValue) 
			{
				isValid	= 	false
				text	=	defaultError
				forceFail ? failed() : null
				return false
			}

			return required ? isValid : true
		}
		
		public function reset( txt:String = null )
		{
			textField.displayAsPassword  	=	false
			text 							= 	txt || defaultText
			target.gotoAndPlay(2)
		}

		public function failed( txt:String = null )
		{
			reset( txt || defaultError )
		}
		
		public function set text( value:String ) 
		{
			textField.text 					=	value
		}
		
		public function get text() 
		{
			return textField.text
		}

	}

}
