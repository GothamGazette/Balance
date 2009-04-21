package project 
{	
	import rageo.components.button.CheckBox;
	import rageo.components.form.Form;
	import rageo.util.StringUtil;
	
	include "index.as"

	public class SubmitPage extends Page
	{

		public var form 		: Form 
		public var checkBox1 	: CheckBox
		public var checkBox2 	: CheckBox
		public var checkBox3 	: CheckBox
		public var newsletters 	: String 
		
		public function SubmitPage( target:MovieClip )
		{
			super( target )
			
			
			form 			=	new Form( target.form , onValidate )
			checkBox1 		= 	new CheckBox( target.newsletter1_box, onCheck )
			checkBox2 		= 	new CheckBox( target.newsletter2_box, onCheck )
			checkBox3 		= 	new CheckBox( target.newsletter3_box, onCheck )
			
			form.required 	= 	["email"]
		}
		
		private function onCheck( whot:Boolean ) 
		{
			form.required = ( checkBox1.check ||  checkBox2.check ||  checkBox3.check ) ? ["email"] : []
		
			var narray : Array = []
			
			if (checkBox1.check) narray.push( target.newsletter1.text )
			if (checkBox2.check) narray.push( target.newsletter2.text )
			if (checkBox3.check) narray.push( target.newsletter3.text )
			
			newsletters = narray.toString()
		}

		public function onValidate( params ) 
		{
			if ( !params ) return
			
			var loader	: URLLoader 	= new URLLoader()
			var request	: URLRequest 	= new URLRequest("budget_submit.php")
            var vars	: URLVariables 	= new URLVariables()

			var var2: Object 			= form.getValues()

			vars.email 					= var2.email
			vars.name 					= var2.name
				
			vars.expenditure_array 		= SliderItem.getArray()
			vars.revenue_array 			= RevenuesItem.getArray()
			vars.deficit_total			= Memory.global.current.deficit
			vars.newsletters 			= newsletters
            request.data 				= vars
			
			loader.load( request )
			
			PageManager.show("ThanksPage")
		}
		
		override public function show() 
		{
			super.show()
			target.value.text = StringUtil.toDollars( Memory.global.current.deficit )
			form.enable()
			onCheck( false )
		}
		
		override public function hide() 
		{
			super.hide()
			if(form) form.disable()
		}
	}	
}
