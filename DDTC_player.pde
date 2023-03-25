import VLCJVideo.*;

//-------------------------------------------------------------
//EXPOSED VAR
//-------------------------------------------------------------
boolean fullScreen = false;
//-------------------------------------------------------------
//INERNAL VAR
//-------------------------------------------------------------
//VIDEO PATH
String [] paths;
String [] ext = {"mp4","m4v"};
//INERNAL VAR
MainVideo mainVideo;
PGraphics layerA;
//-------------------------------------------------------------
//STUDENT EFFECT
//-------------------------------------------------------------
LudovicEffect ludovicEffect;
SarahEffect sarahEffect;
MaxEffect maxEffect;

String currentEffect = "None";

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

	paths = getFilesInDirectory(sketchPath()+"/data/video",ext);
	for (int i = 0; i < paths.length; ++i) {
		println(sketchPath()+"/data/video/"+paths[i]);
		mainVideo.addPath(sketchPath()+"/data/video/"+paths[i]);
	}
	mainVideo.play();
	layerA = createGraphics( width, height, P2D);

	//STUDENT EFFECT
	ludovicEffect = new LudovicEffect();
	sarahEffect = new SarahEffect();
	maxEffect = new MaxEffect();
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

	if(currentEffect == "Ludovic"){
		ludovicEffect.apply(layerA);
	}
	
	//ludovicEffect.apply(layerA);
	layerA.endDraw();

	//---------------------------------------------------------
	//image layer A
	image(layerA, 0, 0);

	//ludovicEffect.postBufer(layerA);
	
	if(currentEffect == "Sarah"){
		sarahEffect.postBufer(layerA);
	}
	if(currentEffect == "Max"){
		maxEffect.postBuffer_pixelArt(layerA,mainVideo.index);
	}
	
	//shader and filter
	mainVideo.run();
	//-------------------------------------------------------------
	//debug mode
	//-------------------------------------------------------------
	
	mainVideo.interfaceDebug(40,height-140);
	noStroke();
	fill(0);
	rect(0,0,80,20);
	fill(255);
	text(frameRate,10,10);
}