/*------------------------------------------------------------------------------------------------------------------

    DOCUMENT
	
	Copyright (C) http://www.gothamgazette.com All Rights Reserved.
	
--------------------------------------------------------------------------------------------------------------------*/


package rageo.system.stage
{
	include "../index.as"

	public class Document extends MovieClip 
	{	
		public static var width				: Number
		public static var height			: Number
		public static var centerX			: Number		
		public static var centerY			: Number
		public static var root				: Sprite
		public static var stage				: Stage
		public static var paused 			: Boolean
		public static var loadConfig		: Boolean = false
		public static var loadAssets		: Boolean = false
		public static var loadLibrary 		: Array = []

		public function Document()
		{
			visible 			= 	false
			Document.root 		=	this
			_checkLoad()
		}

		/*----------------------------
		
		
		
		
			CHECK LOAD!
			
			
			
			
		------------------------------*/

		private function _checkLoad() 
		{

			if ( loadConfig ) 
			{
				new URLConnector( "config.xml", _onConfig )
				return
			}

			if ( loadAssets ) 
			{
				var ass:MovieClip = Object( root )["assets"]
				if ( ass && ass.parent ) {
					_onAssets( ass )
					return
				}
				//new AssetConnector( "content/assets.", _onConfig )
				return
			}

			if ( loadLibrary.length ) 
			{
				//new AssetConnector( "content/assets.", _onLibrary )
				return
			}

			if ( !this.stage ) 
			{
				addEventListener( "enterFrame", _onStage )
				return
			}

			_onLoaded()
		}
		
		/*----------------------------
		
		
		
		
			ON LOAD
			
			
			
			
		------------------------------*/
		
		private function _onConfig( config:Array ) 
		{
			loadConfig 			= 	false
			Memory.config 		= 	ArrayUtil.parseCommas( config )
			//loadLibrary 
			_checkLoad()
		}
		
		private function _onAssets( movieclip:MovieClip ) 
		{
			loadAssets 			= 	false
			PageManager.scan( movieclip )
			_checkLoad()
		}

		private function _onStage( e:Event = null ) 
		{
			if ( !this.stage ) return
			removeEventListener( "enterFrame", _onStage )
			_checkLoad()
		}
		
		private function _onLoaded() 
		{
			Document.root 		= 	this
			Document.stage 		= 	this.stage
			Document.width 		= 	Document.width || stage.stageWidth 
			Document.height 	= 	Document.height || stage.stageHeight
			Document.centerX 	= 	Document.centerX || Document.width / 2
			Document.centerY 	= 	Document.centerY || Document.height / 2
			stage.scaleMode 	= 	StageScaleMode.NO_SCALE
		//	stage.align 		= 	StageAlign.TOP_LEFT
			visible 			= 	true

			Cycle.start()
			Input.start()
			init()
		}
		
		
		/*----------------------------
		
		
		
		
			EXTERNAL CONTROLS
			
			
			
			
		------------------------------*/

		public function init() 
		{
			trace("init")
		}

	}	
}
