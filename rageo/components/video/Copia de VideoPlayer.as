/*------------------------------------------------------------------------------------------------------------------


    START

--------------------------------------------------------------------------------------------------------------------*/

package geeon.components{
	
	include "../index.as"
	
	public class VideoPlayer extends MCWrapper {
		
		var trl;
		var streamSlider, volSlider;
		var holder;
		var btns, stopBtn, playBtn, pauseBtn, textMc
		
		/*-------------------------------------------------------------
	
		CONSTRUCTOR
	
		--------------------------------------------------------------*/
		
		public function VideoPlayer(p){
			super(p);

			textMc				= 	target.textMc;
			textMc				?	textMc.visible = false 											: null;
				
			trl = target.controlsMc;
			
			if (trl){
				streamSlider 	= 	trl.streamSliderMc ? 	new Slider({target:trl.streamSliderMc}) : null;
				volSlider	 	= 	trl.volSliderMc ? 		new Slider({target:trl.volSliderMc}) 	: null;
				
				
				
				// buttons
				btns = trl.buttonsMc; 
				if (btns){
					stopBtn		= 	btns.stopBtn	?	new Button({target:btns.stopBtn,  mouseDown:stop}) 						: null;
					playBtn		=	btns.playBtn	?	new Button({target:btns.playBtn,  mouseDown:pause, mouseUp:pressPlay})	: null;
					pauseBtn	= 	btns.pauseBtn	?	new Button({target:btns.pauseBtn, mouseDown:play, mouseUp:pressPause})	: null;
				}
			}

			// holder
			holder = addChild( FileStream.add({uri:params.uri,fitArea:target.areaMc,streamSlider:streamSlider, timeMc:trl.timeMc}) ) 
			
		}
		
		/*-------------------------------------------------------------
	
		INTERFACE // 
	
		--------------------------------------------------------------*/

		function pressPlay(e=null){
			playBtn.visible		=	false;
			pauseBtn.visible	=	true;
			pause();
		}
		function pressPause(e=null){
			playBtn.visible		=	true;
			pauseBtn.visible	=	false;
			play();
		}
		
		/*-------------------------------------------------------------
	
		CONTROLS // 
	
		--------------------------------------------------------------*/
		
		function pause(e=null){
			holder.play();
		}
		function play(e=null){
			holder.pause();
		}
		function stop(e=null){
			pressPause();
			holder.stop();
		}
	}
}

