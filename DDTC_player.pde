import VLCJVideo.*;

//-------------------------------------------------------------
//EXPOSED VAR
//-------------------------------------------------------------
//Mode fullscreen
boolean fullScreen = false;
//Affichage du debug mode
boolean debug = true;
//Temps en seconde de la durée de l'effet
int timeEffect = 10;
//-------------------------------------------------------------
//INERNAL VAR
//-------------------------------------------------------------
//VIDEO PATH / fichier vidéo reconnue
String[] paths;
//Extension recherché
String[] ext = {"mp4","m4v"};
//INERNAL VAR
MainVideo mainVideo;
PGraphics layerA;
//-------------------------------------------------------------
//STUDENT EFFECT
//-------------------------------------------------------------
LudovicEffect ludovicEffect;
SarahEffect sarahEffect;
SarahEffect2 sarahEffect2;
MaxEffect maxEffect;
MaxEffect2 maxEffect2;
MaxEffect3 maxEffect3;
MaxEffect4 maxEffect4;
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
	
	initUdp();

	paths = getFilesInDirectory(sketchPath() + "/data/video",ext);
	for (int i = 0; i < paths.length; ++i) {
		println(sketchPath() + "/data/video/" + paths[i]);
		mainVideo.addPath(sketchPath() + "/data/video/" + paths[i]);
	}
	mainVideo.play();
	layerA = createGraphics(width, height, P2D);
	
	//-------------------------------
	//DECLARATION DES EFFETS
	//-------------------------------
	addEffect("None");
	//STUDENT EFFECT
	ludovicEffect = new LudovicEffect();
	addEffect("Ludovic");

	sarahEffect = new SarahEffect();
	addEffect("Sarah_A_1");
	addEffect("Sarah_A_2");
	addEffect("Sarah_A_3");
	addEffect("Sarah_A_4");

	sarahEffect2 = new SarahEffect2(layerA);
	addEffect("Sarah_B_1");
	addEffect("Sarah_B_2");
	addEffect("Sarah_B_3");
	addEffect("Sarah_B_4");

	maxEffect = new MaxEffect();
	addEffect("Max");
	maxEffect2 = new MaxEffect2();
	addEffect("Max2");
	maxEffect3 = new MaxEffect3();
	addEffect("Max3");
	maxEffect4 = new MaxEffect4(layerA);
	addEffect("Max4");
	//-------------------------------
}

//-------------------------------------------------------------
//DRAW
//-------------------------------------------------------------
void draw() {
	background(0);
	//---------------------------------------------------------
	//routine de control des effets
	runController();
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
	
	//-------------------------------------------------------------
	//POST BUFFER EFFECT
	//-------------------------------------------------------------
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
	// MAX EFFECT 1 ---------------------------------------------------------
	if (currentEffect == "Max") {
		maxEffect.postBuffer_pixelArt(layerA,mainVideo.index);
	}
	// MAX EFFECT 2 ---------------------------------------------------------
	if (currentEffect == "Max2") {
		maxEffect2.postBuffer_square(layerA);
	}
	// MAX EFFECT 3 ---------------------------------------------------------
	if (currentEffect == "Max3") {
		maxEffect3.postBuffer_printMvt(mainVideo.index);
	}
	// MAX EFFECT 4 ---------------------------------------------------------
	if (currentEffect == "Max4") {
		maxEffect4.postBuffer_boom(layerA);
	}
	
	//shader and filter
	mainVideo.run();
	//-------------------------------------------------------------
	//debug mode
	//-------------------------------------------------------------
	if (debug ==  true) {
		mainVideo.interfaceDebug(40,height - 140);
		effectDebugDraw();
		debugController();
	}
}