class SarahEffect{
	
	
	PImage[] tabTrame_1;
	PImage[] tabTrame_2;
	PImage[] tabTrame_3;
	PImage[] tabTrame_4;
	String[] ext = {"png"};
	int inc = 25;
	//-------------------------------------------------------------
	//Sarah Effect
	//-------------------------------------------------------------
	SarahEffect() {
		tabTrame_1 = loadData(sketchPath()+"/data/dataSarah/1/");
		tabTrame_2 = loadData(sketchPath()+"/data/dataSarah/2/");
		tabTrame_3 = loadData(sketchPath()+"/data/dataSarah/3/");
		tabTrame_4 = loadData(sketchPath()+"/data/dataSarah/4/");
		
		hint(DISABLE_TEXTURE_MIPMAPS);
  	((PGraphicsOpenGL)g).textureSampling(3); 
	}
	
	//-------------------------------------------------------------
	//LOAD DYNAMIC DATA
	//-------------------------------------------------------------
	PImage [] loadData(String path){
		String[] files = getFilesInDirectory(path, ext);
		println(files.length);
		PImage [] tabTrame = new PImage[files.length];
		for (int i = 0; i < files.length; i++) {
			println(">loading image sarah   "+path+files[i]);
			tabTrame[i] = loadImage(path + files[i]);
		}
		return tabTrame;
	}
	//-------------------------------------------------------------
	//
	//-------------------------------------------------------------
	void apply(PGraphics p) {
		
		
	}
	
	//-------------------------------------------------------------
	//
	//-------------------------------------------------------------
	void postBufer(PGraphics p,int tabNumber) {
		if (frameCount % 2 ==  0)p.loadPixels();
		
		if (frameCount > 2 && p.pixels!=null && p.pixels.length > 0) {
			for (int x = 0;x < width;x += inc) {
				for (int y = 0;y < height;y += inc) {
					int c = p.pixels[y * width + x];
					int r = (c>>16) & 0xFF;
					
					//if(r>125)
					if(tabNumber==1){
						int index = (int)map(r, 0, 255, 0, tabTrame_1.length - 1);
						image(tabTrame_1[index], x, y,inc,inc);
					}
					if(tabNumber==2){
						int index = (int)map(r, 0, 255, 0, tabTrame_2.length - 1);
						image(tabTrame_2[index], x, y,inc,inc);
					}
					if(tabNumber==3){
						int index = (int)map(r, 0, 255, 0, tabTrame_3.length - 1);
						image(tabTrame_3[index], x, y,inc,inc);
					}
					if(tabNumber==4){
						int index = (int)map(r, 0, 255, 0, tabTrame_4.length - 1);
						image(tabTrame_4[index], x, y,inc,inc);
					}

				}
			}
		} 
	}
	
}