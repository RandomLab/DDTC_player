import hypermedia.net.*;

int udpPort = 4200;
UDP udp;
String txt = "";

//-------------------------------------------------------------
//CONTRUCTOR
//-------------------------------------------------------------
void iniUdp() {
	  size(500, 200);
	  udp = new UDP(this, udpPort);
	  //udp.log(true);//printout the connection activity
	  udp.listen(true);
}

//-------------------------------------------------------------
//RUN
//-------------------------------------------------------------
void drawUdp() {
	  background(0);
	  fill(255);
	  text(txt,20,20);
}

//-------------------------------------------------------------
//RECEPTION
//-------------------------------------------------------------
void receive(byte[] data, String ip, int port) {	// <-- extended handler
	  String message = new String(data);
	  // print the result
	  //println("receive: \""+message+"\" from " + ip + " on port " + port);
	  //txt = millis() + " | receive: "+message+" | from: " + ip + " | port: " + port;
		
		if(message.length()>1){
			sendToControl(message);
		}
}

/*
void keyPressed() {
	  String message  = str(key);	// the message to send
	  String ip       = "localhost";	// the remote IP address
	  int port        = 6001;		// the destination port
	  // formats the message for Pd
	  message = message + ";\n";
	  // send the message
	  udp.send(message, ip, port);
	  //byte [] d = {55,57,58};
	  //udp.send(d, ip, port );
}
*/