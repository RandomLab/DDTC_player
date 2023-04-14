import VLCJVideo.*;

//-------------------------------------------------------------
//EXPOSED VAR
//-------------------------------------------------------------
boolean fullScreen = false;
boolean debug = true;
int timeEffect = 10;
//-------------------------------------------------------------
//INERNAL VAR
//-------------------------------------------------------------
//VIDEO PATH
String[] paths;
String[] ext = {"mp4","m4v"};
//INERNAL VAR
MainVideo mainVideo;
PGraphics layerA;
//-------------------------------------------------------------
//STUDENT EFFECT
//-------------------------------------------------------------
LudovicEffect ludovicEffect;
SarahEffect sarahEffect;
MaxEffect maxEffect;
SarahEffect2 sarahEffect2;
//-------------------------------------------------------------
//SETTINGS
//-------------------------------------------------------------
void settings() {
	if (fullScreen)
		fullScreen(P2D);
	else
		size(1920, 1080, P2D);
}
//-------------------------------------------------------------
//SETUP
//-------------------------------------------------------------
void setup() {
	mainVideo = new MainVideo(this);
	
	paths = getFilesInDirectory(sketchPath() + "/data/video",ext);
	for (int i = 0; i < paths.length; ++i) {
		println(sketchPath() + "/data/video/" + paths[i]);
		mainVideo.addPath(sketchPath() + "/data/video/" + paths[i]);
	}
	mainVideo.play();
	layerA = createGraphics(width, height, P2D);
	
	addEffect("None");
	//STUDENT EFFECT
	ludovicEffect = new LudovicEffect();
	addEffect("Ludovic");

	sarahEffect = new SarahEffect();
	addEffect("Sarah_A_1");
	addEffect("Sarah_A_2");
	addEffect("Sarah_A_3");
	addEffect("Sarah_A_4");

	maxEffect = new MaxEffect();
	addEffect("Max");

	sarahEffect2 = new SarahEffect2(layerA);
	addEffect("Sarah_B_1");
	addEffect("Sarah_B_2");
	addEffect("Sarah_B_3");
	addEffect("Sarah_B_4");
}

//-------------------------------------------------------------
//DRAW
//-------------------------------------------------------------
void draw() {
	background(0);
	//---------------------------------------------------------
	//LAYER A / video
	//---------------------------------------------------------
	layerA.beginDraw();
	layerA.background(0);
	
	if (mainVideo.getVideo().isPlaying())
		layerA.image(mainVideo.getVideo(), 0, 0,width, height);
	
	if (currentEffect == "Ludovic") {
		ludovicEffect.apply(layerA);
	}
	
	//ludovicEffect.apply(layerA);
	layerA.endDraw();
	
	//---------------------------------------------------------
	//image layer A
	image(layerA, 0, 0);
	
	//ludovicEffect.postBufer(layerA);
	
	// SARAH EFFECT 1 ---------------------------------------------------------
	if (currentEffect == "Sarah_A_1") {
		sarahEffect.postBufer(layerA,1);
	}
	if (currentEffect == "Sarah_A_2") {
		sarahEffect.postBufer(layerA,2);
	}
	if (currentEffect == "Sarah_A_3") {
		sarahEffect.postBufer(layerA,3);
	}
	if (currentEffect == "Sarah_A_4") {
		sarahEffect.postBufer(layerA,4);
	}
	// MAX EFFECT 1 ---------------------------------------------------------
	if (currentEffect == "Max") {
		maxEffect.postBuffer_pixelArt(layerA,mainVideo.index);
	}
	// SARAH EFFECT 2 ---------------------------------------------------------
	if (currentEffect == "Sarah_B_1") {
	  sarahEffect2.postBuffer(layerA);
	}
	if (currentEffect == "Sarah_B_2") {
	  sarahEffect2.postBuffer2(layerA);
	}
	if (currentEffect == "Sarah_B_3") {
	  sarahEffect2.postBuffer3(layerA);
	}
	if (currentEffect == "Sarah_B_4") {
	  sarahEffect2.postBuffer4(layerA);
	}
	//shader and filter
	mainVideo.run();
	//-------------------------------------------------------------
	//debug mode
	//-------------------------------------------------------------
	if (debug ==  true) {
		mainVideo.interfaceDebug(40,height - 140);
		effectDebugDraw();
	}
}