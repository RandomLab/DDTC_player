class MaxEffect3{
	
	PGraphics img;
	boolean[] changed;
	float tol = 15;   //différence de couleur minimum pour admettre une variation
	int tiVid = -1;
	int size_max3 = 2;
	int timer;
	int time_wait = 6;
	float diffR, diffG, diffB;
	
	MaxEffect3() {
		img = createGraphics(layerA.width,  layerA.height);
		changed = new boolean[layerA.width * layerA.height];
		img.noStroke();
	}
	
	void postBuffer_printMvt(int indexVideo) {
		image(img, 0,0,width,height);
		img.beginDraw();
		
		pixelLook();
		videoNext(indexVideo);
		
		img.endDraw();
	}
	
	void pixelLook() {
		img.loadPixels();
		layerA.loadPixels();
		for (int y = 0; y < layerA.height; y += size_max3) {
			for (int x = 0; x < layerA.width; x += size_max3) {
				int index = x + y * layerA.width;
				
				//calcul des différence r, g et b de couleurs des pixels
				diffR = abs(red(color(img.pixels[index])) - red(color(layerA.pixels[index])));
				diffG = abs(green(color(img.pixels[index])) - green(color(layerA.pixels[index])));
				diffB = abs(blue(color(img.pixels[index])) - blue(color(layerA.pixels[index])));
				
				//comparaison avec la tolérance
				if ((diffR > tol) && (diffG > tol) && (diffB > tol)) {
					if (!changed[index])         pixelDisplay(index, x, y);
					changed[index] = true;
					}
				}
			}
	}
	
	void pixelDisplay(int Tindex, int Tx, int Ty) {
		img.fill(color(layerA.pixels[Tindex]));
		img.rect(Tx, Ty, size_max3, size_max3);
	}
	
	void videoNext(int iVid) {
		if (tiVid!= iVid) {
			timer ++;
			if (timer >= time_wait) {
				img = createGraphics(layerA.width,  layerA.height);
				img.beginDraw();
				img.image(layerA, 0, 0, layerA.width, layerA.height); //image mémoire
				img.noStroke(); 
				img.endDraw();
				
				for (int i = 0; i < changed.length; i++) changed[i] = false;
				
				tiVid = iVid;
				timer = 0;
				}
			}     
	}
}