class MainVideo{
	
	String[] paths = {};
	PApplet parent;
	VLCJVideo video;
	int index=0;
	String state="";
	//-------------------------------------------------------------
	//Constructor
	//-------------------------------------------------------------
	MainVideo(PApplet p) {
		System.out.println("MainVideo init");
		parent = p;
		video = new VLCJVideo(parent);
		video.setRepeat(true);
		
		video.bind(VLCJVideo.MediaPlayerEventType.FINISHED, new Runnable() { public void run() {
	  	state = "FINISHED";
		}});
		video.bind(VLCJVideo.MediaPlayerEventType.ERROR, new Runnable() { public void run() {
	  	println("ERROR");
		}});
	}
	
	//-------------------------------------------------------------
	//Add path
	//-------------------------------------------------------------
	void addPath(String newPath) {
		paths = append(paths, newPath);
	}
	
	//-------------------------------------------------------------
	//Play
	//-------------------------------------------------------------
	void play() {
		if (paths.length > 0) {
			video.openAndPlay(paths[index]);
			index=0;
		}
	}

	//-------------------------------------------------------------
	//nextVideo
	//-------------------------------------------------------------
	void nextVideo() {
		println("nextVideo");
		index++;
		if (index >= paths.length) {
			index = 0;
		}
		video.open(paths[index]);
		video.play();
	}

	//-------------------------------------------------------------
	//RUN
	//-------------------------------------------------------------
	void run(){
		if(state=="FINISHED"){
			nextVideo();
			state="";
		}
	}
	//-------------------------------------------------------------
	//GETVIDEO
	//-------------------------------------------------------------
	VLCJVideo getVideo() {
		return video;
	}

	//-------------------------------------------------------------
	//Interface debug
	//-------------------------------------------------------------
	void interfaceDebug(int x,int y){
		fill(0);
		rect(x,y,800,100);

		fill(255);
		text(
			"Index : "+index+
			" / "+(paths.length-1)+
			"    paths : "+paths[index]
		,x+10,y+20);
		
		String currentTime="none";
		String maxTime="none";

		if(video.isPlaying()){
			currentTime=nf(video.position()*video.duration()/1000,0,2);
			maxTime=nf(video.duration()/1000,0,2);
		}
		text(currentTime+" / "+maxTime,x+10,y+40);

		float leng=800-20;
		noFill();
		stroke(255);
		rect(x+10,y+60,leng,10);

		if(video.isPlaying()){
			float pos = map(video.position(),0,1,0,leng);
			fill(255);
			rect(x+10,y+60,pos,10);
		}
	}



	
}