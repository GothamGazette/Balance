package rageo.util
{	
	include "../index.as"
	
	public class DragUtil 
	{		
		public static function start(i:Sprite)
		{
			i.addEventListener("mouseDown", startDragEvent)
			i.addEventListener("mouseUp", stopDragEvent)
		}
		
		public static function stop(i:Sprite)
		{
			i.removeEventListener("mouseDown", startDragEvent)
			i.removeEventListener("mouseUp", stopDragEvent)
		}
		
		private static function startDragEvent(e:Event)
		{
			e.target.startDrag( true )
		}
		
		private static function stopDragEvent(e:Event)
		{
			e.target.stopDrag()
		}
	}	
}