class SarahEffect2 {
	PGraphics pg;
	int inc = 25;
	int inc2 = 10;
	//-------------------------------------------------------------
	//Sarah Effect2
	//-------------------------------------------------------------
	SarahEffect2(PGraphics p) {
		pg = createGraphics(p.width, p.height);
	}

	//-------------------------------------------------------------
	//
	//-------------------------------------------------------------
	void apply(PGraphics p) {
	}
	
	//-------------------------------------------------------------
	//Sarah post effect 1
	//-------------------------------------------------------------
	void postBuffer(PGraphics p) {
		background(0);
		p.loadPixels();
		fill(255,255,255,20);
		noStroke();
		for (int x = 0; x < p.width; x += inc) {
			for (int y = 0; y < p.height; y += inc) {
				color c = color(p.pixels[y * p.width + x]);
				
				float b = brightness(c);
				//println(b);
				b = map(b, 0, 255, inc, 60);
				//strokeWeight(2);
				circle(x, y, b);
			}
		}
	}
	
	//-------------------------------------------------------------
	//Sarah post effect 2
	//-------------------------------------------------------------
	void postBuffer2(PGraphics p) {
		background(0);
		p.loadPixels();
		fill(255);
		noStroke();
		for (int x = 0; x < p.width; x += inc) {
			for (int y = 0; y < p.height; y += inc) {
				color c = color(p.pixels[y * p.width + x]);
				
				float b = brightness(c);
				//println(b);
				b = map(b, 0, 255, 0, inc);
				//strokeWeight(2);
				circle(x, y, b);
			}
		}
	}
	
	//-------------------------------------------------------------
	//Sarah post effect 3
	//-------------------------------------------------------------
	void postBuffer3(PGraphics p) {
		background(0);
		p.loadPixels();
		noFill();
		stroke(255);
		for (int x = 0; x < p.width; x += inc) {
			for (int y = 0; y < p.height; y += inc) {
				color c = color(p.pixels[y * p.width + x]);
				
				float b = brightness(c);
				//println(b);
				b = map(b, 0, 255, inc, 40);
				//strokeWeight(2);
				circle(x, y, b);
			}
		}
	}
	
	//-------------------------------------------------------------
	//Sarah post effect 4
	//-------------------------------------------------------------
	void postBuffer4(PGraphics p) {
		background(255);
		p.loadPixels();
		fill(0);
		noStroke();
		for (int x = 0; x < p.width; x += inc2) {
			for (int y = 0; y < p.height; y += inc2) {
				color c = color(p.pixels[y * p.width + x]);
				
				float b = brightness(c);
				//println(b);
				b = map(b, 0, 255, inc2, 20);
				//strokeWeight(2);
				circle(x, y, b);
			}
		}
	}
}