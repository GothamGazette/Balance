package rageo.system.stage
{
	include "../index.as"

	public class Quality {

		public static var renderQuality				: String = "HIGH"
		public static var interfaceQuality			: String = "HIGH"
		public static var gameQuality				: String = "LOW"
		public static var interfaceFPS				: int = 33
		public static var gameFPS					: int = 100
		public static var stage						: Stage = Document.stage

				
		// RENDER QUALITY
		public static function render (){
			
			if (!stage){return}
			
			stage.quality 		=	renderQuality
			stage.frameRate 	=	interfaceFPS

		}
		
		// INTERFACE QUALITY
		public static function high (){
			
			if (!stage){return}
			
			stage.quality 		=	interfaceQuality
			stage.frameRate 	=	interfaceFPS
			
		}
		
		public static function low() {
			
			stage.quality = "LOW"
			
		}
		
		// GAME QUALITY
		public static function game (){
			
			if (!stage){return}
			
			stage.quality 		=	gameQuality
			stage.frameRate 	=	gameFPS

		}
		
		
	}
}


	