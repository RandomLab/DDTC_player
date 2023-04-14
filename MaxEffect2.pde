class MaxEffect2{
	ArrayList <PVector> square = new ArrayList <PVector> ();
	float size = 50;
	int maxLength = 5000;
	int speed = 8;
	
	MaxEffect2() {
	}
	
	void postBuffer_square(PGraphics cam) { 
		cam.loadPixels();
		
		for (int i = 0; i < speed; i++) {
			int x = floor(random(cam.width));
			int y = floor(random(cam.height));
			
			square.add(new PVector(x, y));
			
			if (square.size()>= maxLength) {
				square.remove(0);
				}
			}
		
		for (PVector c : square) {
			color col = color(cam.pixels[floor(c.x) + floor(c.y) * cam.width]);
			fill(col);
			noStroke();
			rect(c.x - size / 2, c.y  - size / 2, size, size);
			}
	}    
}