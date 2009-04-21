
package rageo.components.form 
{
	import flash.display.MovieClip;
	import rageo.components.button.Button;
	
	include "../index.as"
	
	public class Form
	{
	
		public var required 	: Array = []
		
		public var onValidate 	: Function
		private var target 		: MovieClip
		private var submitBtn 	: Button
		
		public var fields 		: Object
		
		public function Form( target:MovieClip, onValidate:Function = null )
		{
			this.target 		=	target
			this.onValidate 	=	onValidate

			Button.pullSimple( target.validate_btn, validate )
			
			fields 				=	FormField.search( target )
			
			for ( var n in fields ) required.push( n )
			
			enable()
		}
		
		public function validate() 
		{
			var isValid : Boolean = true
			for ( var n in required ) if ( !fields[ required[n] ].validate( true ) ) isValid = false
			
			var result 	=	isValid 	?  fields : false
			if( onValidate != null ) onValidate( result )
			return result
		}
		
		public function enable() 
		{
			for ( var n in fields ) fields[n].enable()
			target.visible = true
		}
		
		public function disable() 
		{
			for ( var n in fields ) fields[n].disable()
			target.visible = false
		}
		
		public function getValues() 
		{
			var output : Object = {}
			for ( var n in fields) output[ fields[n].name ] = fields[n].text 
			return output
		}
		
		
	}
}
