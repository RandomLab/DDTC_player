import VLCJVideo.*;
//-------------------------------------------------------------
//VIDEO PATH
//-------------------------------------------------------------
String [] paths = {
	"/data/video/Artemiy.MP4",
	"/data/video/Kaisa.MP4",
	"/data/video/Kristi.MP4",
	"/data/video/Mark.MP4",
	"/data/video/Natsumi.MP4"
};

//-------------------------------------------------------------
//EXPOSED VAR
//-------------------------------------------------------------
boolean fullScreen = false;
//-------------------------------------------------------------
//INERNAL VAR
//-------------------------------------------------------------
MainVideo mainVideo;
PGraphics layerA;

//-------------------------------------------------------------
//STUDENT EFFECT
//-------------------------------------------------------------
LudovicEffect ludovicEffect;

//-------------------------------------------------------------
//SETTINGS
//-------------------------------------------------------------
void settings(){
	if(fullScreen)
		fullScreen(P2D);
	else
		size(1920, 1080, P2D);
}
//-------------------------------------------------------------
//SETUP
//-------------------------------------------------------------
void setup() {
	mainVideo = new MainVideo(this);

	for (int i = 0; i < paths.length; ++i) {
		println(sketchPath()+paths[i]);
		mainVideo.addPath(sketchPath()+paths[i]);
	}
	mainVideo.play();
	
	layerA = createGraphics( width, height, P2D);

	//STUDENT EFFECT
	ludovicEffect = new LudovicEffect();

}

//-------------------------------------------------------------
//DRAW
//-------------------------------------------------------------
void draw(){
	background(0);
	//---------------------------------------------------------
	//LAYER A / video
	//---------------------------------------------------------
	layerA.beginDraw();
	layerA.background(0);
	
	
	if(mainVideo.getVideo().isPlaying())
		layerA.image(mainVideo.getVideo(), 0, 0,width, height);
	
	ludovicEffect.apply(layerA);
	layerA.endDraw();

	//---------------------------------------------------------
	image(layerA, 0, 0);

	//println("s");
	ludovicEffect.postBufer(layerA);
	
	

	//shader and filter
	mainVideo.run();
	mainVideo.interfaceDebug(40,height-140);
}