void keyPressed(){
	print(keyCode+" - ");

	//debug du clavier
	if(key=='a')mainVideo.nextVideo();
	if(key=='z')mainVideo.video.setPosition(0.99);

	//debug mode de la console
	if(keyCode==32)debug=!debug;

	//178 - 38 - 233 - 34 - 39 - 40 - 45 - 232 - 95 - 231 - 224 - 41 - 61
	//touches numéraire du clavier
	if(keyCode==178){
		currentEffect="None";
	}

	if(keyCode==DOWN){
		nextEffect();
	}
	if(keyCode==UP){
		previousEffect();
	}
}