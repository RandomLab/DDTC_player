class LudovicEffect{
	PShader shader;
	
	float t=0;

	LudovicEffect(){
		shader = loadShader(sketchPath()+"/data/shaders/sobel.glsl");

		println("iResolution  "+width+"  "+height);
		shader.set("iResolution", float(width), float(height));
	}

	void apply(PGraphics p){
		shader.set("iResolution", float(width), float(height));
		shader.set("dec",0.75+sin(t)*0.25);
		//shader.set("dec",3.3);
		p.filter(shader);
		
		t+=0.01;
		//println(p.width+"  "+p.height);
	}

	void postBufer(PGraphics p){
		p.loadPixels();
		//p.updatePixels();

		for(int i=0;i<p.width;i+=15){
			for(int j=0;j<p.height;j+=15){
				color c = p.pixels[i+j*p.width];
				fill(c);
				noStroke();
				rect(i,j,10,10);
			}
		}
	}	

	//----------------------------------------------
}
