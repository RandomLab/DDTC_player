void keyPressed(){
	print(keyCode+" - ");

	if(key=='a')mainVideo.nextVideo();
	if(key=='z')mainVideo.video.setPosition(0.99);


	//178 - 38 - 233 - 34 - 39 - 40 - 45 - 232 - 95 - 231 - 224 - 41 - 61
	//touches numéraire du clavier
	if(keyCode==178){
		currentEffect="None";
	}
	if(keyCode==38){
		currentEffect="Ludovic";
	}
	if(keyCode==233){
		currentEffect="Sarah";
	}
	if(keyCode==34){
		currentEffect="Max";
	}
	if(keyCode==39){
	}
	if(keyCode==40){
	}
	if(keyCode==45){
	}
	if(keyCode==232){
	}
	if(keyCode==95){
	}
	if(keyCode==231){
	}
	if(keyCode==224){
	}
	if(keyCode==41){
	}
	if(keyCode==61){	
	}
}