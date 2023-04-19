class BenoitEffect{
	PShader shader1;
	PShader shader2;
	
	float time = 0;

	BenoitEffect(){
		shader1 = loadShader(sketchPath()+"/data/shaders/ess2.glsl");
		shader1.set("u_resolution", float(width), float(height));
		shader2 = loadShader(sketchPath()+"/data/shaders/ess3.glsl");
		shader2.set("u_resolution", float(width), float(height));
	}

	void apply_1(PGraphics p){
		shader1.set("u_time",time);
		p.filter(shader1);
		
		time+=0.01;
	}

	void apply_2(PGraphics p){
		shader2.set("u_time",time);
		p.filter(shader2);
		
		time+=0.01;
	}

	//----------------------------------------------
}
