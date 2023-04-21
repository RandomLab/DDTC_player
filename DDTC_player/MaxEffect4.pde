float initVel = 3;
PVector grav = new PVector(0,1);
int size_max4 = 10;

class MaxEffect4{
	PGraphics img;
	
	ArrayList <Pixels> pix = new ArrayList <Pixels>();
	int maxSize = 20000;
	int sclo = 15;
	
	float tol = 25;   //différence de couleur minimum pour admettre une variation
	float tolWhite = 90;
	//-------------------------------------------------------------
	//	MaxEffect4
	//-------------------------------------------------------------
	MaxEffect4(PGraphics tcam) {
		img = createGraphics(tcam.width,  tcam.height);
	}
	
	//-------------------------------------------------------------
	//	postBuffer_boom
	//-------------------------------------------------------------
	void postBuffer_boom(PGraphics cam) {
		for (int i = pix.size() - 1; i >= 0; i--) {
			if (pix.size()>maxSize) {
				pix.remove(i);
			} else{
				Pixels p = pix.get(i);
				p.update();
				p.display();
			}   
		}
		
		img.beginDraw();
		cam.loadPixels();
		
		if (img.pixels != null) pixelLook(cam);
		img.image(cam, 0, 0, cam.width, cam.height);
		
		img.endDraw();
	}
	
	//-------------------------------------------------------------
	//	pixelLook
	//-------------------------------------------------------------
	void pixelLook(PGraphics cam) {
		img.loadPixels();
		for (int y = 0; y < cam.height; y += sclo) {
			for (int x = 0; x < cam.width; x += sclo) {
				int index = x + y * cam.width;
				
				if ((red(color(cam.pixels[index])) + green(color(cam.pixels[index])) + blue(color(cam.pixels[index]))) / 3 < 255 - tolWhite 
					&& (red(color(cam.pixels[index])) + green(color(cam.pixels[index])) + blue(color(cam.pixels[index]))) / 3 > tolWhite) {
					//calcul des différence r, g et b de couleurs des pixels
					float diffR = abs(red(color(img.pixels[index])) - red(color(cam.pixels[index])));
					float diffG = abs(green(color(img.pixels[index])) - green(color(cam.pixels[index])));
					float diffB = abs(blue(color(img.pixels[index])) - blue(color(cam.pixels[index])));
					
					//comparaison avec la tolérance
					if ((diffR > tol) && (diffG>tol) && (diffB>tol)) {
						pix.add(new Pixels(x, y, color(cam.pixels[index])));
					}
				}
			}
		}
	}
	
	//-------------------------------------------------------------
	//	Pixels
	//-------------------------------------------------------------
	class Pixels {
		PVector vel, pos;
		color col;
		
		Pixels(float tx, float ty, color tcol) {
			pos = new PVector(tx, ty);
			vel = new PVector(random( -initVel, initVel), random( -initVel));
			col = tcol;
		}
		
		void update() {
			vel.add(grav);
			pos.add(vel);
			if (pos.y > height || pos.x < 0 || pos.x > width) pix.remove(this);
		}
		
		void display() {
			noStroke();
			fill(col);
			rect(pos.x,pos.y, size_max4 , size_max4);
		}
	}
}