package rageo.system.debug
{
	include "../index.as"

	public class Debug {
		
		public static var mode			: Boolean = false
		
		private static var captions		: Array = new Array()
		private static var values		: Array = new Array()
		private static var controls		: Array = new Array()		
		private static var object		: Sprite = new Sprite()		
		
		public static function addValue(caption:String, value:Object = ""):int
		{			
			var t:TextField = new TextField()
				t.backgroundColor = 0x000000
				t.background = true
				t.textColor = 0xFFFFFF
				t.autoSize = TextFieldAutoSize.LEFT
				t.text = caption + " : " + value.toString()
				t.y = controls.length * 22
				t.selectable = false
				
			object.addChild(t)
			object.cacheAsBitmap = true
				
			captions.push(caption)
			values.push(value)
			controls.push(t)
			
			return controls.length - 1
		}
		
		public static function setValue(caption:String, value:Object) 
		{	
			var index:int = captions.indexOf(caption) 			
			if (index < 0) index = addValue(caption, value)
			values[index] = value			
			controls[index].text = caption + " : " + value.toString()
		}
		
		/**
		 * Muestra las variables de debug sobre el stage.
		 */
		public static function show( )
		{
			if (Document.stage) Document.stage.addChild(object)
		}
		
		/**
		 * Devuelve una referencia al objeto Debug.
		 */
		public static function getObject():Sprite 
		{
			return object
		}	
		
		public static function print( target, message = "" )
		{
			var output : String = ""
			
			if ( message.length){
				output =  "-------------------------------------- \n"  
				output += "PRINT:"+message+"\n";
				output += "-------------------------------------- \n"  
			}			
			
			output += StringUtil.toString( target )
			
			trace(output)
		}
		
		public static function graphics():Graphics
		{
			return object.graphics
		}
	}	
}
