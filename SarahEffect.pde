class SarahEffect{
	
	
	PImage[] tabTrame;
	String path = "/data/dataSarah/";
	String[] ext = {"png"};
	int inc = 25;
	//-------------------------------------------------------------
	//Sarah Effect
	//-------------------------------------------------------------
	SarahEffect() {
		String[] files = getFilesInDirectory(sketchPath() + path, ext);
		println(files.length);
		tabTrame = new PImage[files.length];
		
		for (int i = 0; i < files.length; i++) {
			tabTrame[i] = loadImage(sketchPath() + path + files[i]);
		}
		
		hint(DISABLE_TEXTURE_MIPMAPS);
  	((PGraphicsOpenGL)g).textureSampling(3); 
		
	}
	
	//-------------------------------------------------------------
	//
	//-------------------------------------------------------------
	void apply(PGraphics p) {
		
		
	}
	
	//-------------------------------------------------------------
	//
	//-------------------------------------------------------------
	void postBufer(PGraphics p) {
		if (frameCount % 2 ==  0)p.loadPixels();
		
		if (frameCount > 2 && p.pixels!=null && p.pixels.length > 0) {
			for (int x = 0;x < width;x += inc) {
				for (int y = 0;y < height;y += inc) {
					int c = p.pixels[y * width + x];
					int r = (c>>16) & 0xFF;
					
					int index = (int)map(r, 0, 255, 0, tabTrame.length - 1);
					//if(r>125)
					image(tabTrame[index], x, y,inc,inc);
				}
			}
		} 

	}
	
}