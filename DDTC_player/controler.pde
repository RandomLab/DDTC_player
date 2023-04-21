//-------------------------------------------------------------
//CONTROL MESSAGE
//-------------------------------------------------------------
void sendToControl(String message) {
	time = millis() + timeEffect * 1000;	
	refTime = millis();
	timerActive=true;
	
	String m = message;
	
	if(m.charAt(0)=='d'){
		m = m.substring(1);
		int nb = int(float(m));
		jumpToEffect(nb);
	}
}
//-------------------------------------------------------------
//RUN THE CONTROLLER
//-------------------------------------------------------------
int time;
int refTime;
boolean timerActive=true;

void runController() {
	if(timerActive){
		if(millis()>time){
			jumpToEffect(0);
			timerActive=false;
		}
	}
}
//-------------------------------------------------------------
//DEBUG CONTROLLER
//-------------------------------------------------------------
void debugController(){
	int px=10;
	int py=70;
	int pw=430;
	int ph=40;

	fill(0);
	noStroke();
	rect(px,py,pw,ph);

	stroke(0,0,255);
	noFill();
	rect(px+10,py+10,pw-20,20);

	if(timerActive){
		fill(0,0,255);
		float l = map(millis(),time,refTime,0,pw-20);
		rect(px+10,py+10,l,20);
	}
}