/**
* ...
* @author Ariel Nehmad
* @version 0.1
*/

package gna.system {
	
	include "../_import.as"

	public class CubloGame extends Document
	{	

		Document.width 		=	720
		Document.height 	=	540
		
		public static var cam		: Cam

		public function Game()
		{
			Game.cam = new Cam()	
			Device.initialize( 0, 0, Document.width, Document.height )
			Device.addBuffer( new Buffer( "default" ), this )
			Device.setBuffer( "default" )
		}
		

		override public function updateEvent() 
		{
			if( Document.paused ) return
			
			for each (var s:Screen in screens) if (s.active) { s.updateEvent(); if (s.pauseFlow) break }
			for each ( var m:MovieClip3D in MovieClip3D.updateMovies ) m.updateEvent()
			update()
			renderEvent( null )
		}
		
		private function renderEvent( e:Event = null )
		{
			cam.calculateView()
			
			render()

			for each (var s:Screen in screens) if (s.active) { s.renderEvent(); if (s.pauseFlow) break }
			
			Device.render()
			postRender()
			Debug.setValue("tris", Device.tris)
			Device.tris = 0
		}
		
		public function postRender(){}

	}	
}
