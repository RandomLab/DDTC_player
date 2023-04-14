//-------------------------------------------------------------
//EFFECT GESTIONNAIRE
//-------------------------------------------------------------
String currentEffect = "None";
int indexEffect=0;
String [] registerEffect = {};
//-------------------------------------------------------------
//REGISTER EFFECT
//-------------------------------------------------------------
void addEffect(String name) {
	registerEffect = append(registerEffect, name);
}

void nextEffect() {
	indexEffect++;
	if (indexEffect >= registerEffect.length)
		indexEffect = 0;
	currentEffect = registerEffect[indexEffect];
}

void previousEffect() {
	indexEffect--;
	if (indexEffect < 0)
		indexEffect = registerEffect.length - 1;
	currentEffect = registerEffect[indexEffect];
}

void jumpToEffect(int i){
	currentEffect = registerEffect[i];
	indexEffect = i;
}

//-------------------------------------------------------------
//EFFECT DEBUG DRAW
//-------------------------------------------------------------
void effectDebugDraw() {
	noStroke();
	
	String msg = "fps : " + frameRate + "\n";
	msg += "Press up and down to scroll effects ";
	msg += " | Thank to Student of 3D Création numérique";
	msg += " | we have "+int(registerEffect.length-1)+" effects";
	
	textAlign(LEFT,CENTER);
	fill(0);
	noStroke();
	rect(10,10,textWidth(msg+10)+20,50);
	fill(255);
	text(msg,10,10,textWidth(msg+10)+20,50);

	//----------------------------
	textAlign(LEFT,BOTTOM);
	int px=20;
	int py=300;
	int inter=20;

	for(int i=0;i<registerEffect.length;i++){
		fill(0);
		noStroke();
		rect(px,-14+py+i*inter,100,20);

		if(currentEffect==registerEffect[i]){
			fill(0,255,0);
		}else{
			fill(255);
		}
		text(registerEffect[i],px,py+i*inter);
	}
}