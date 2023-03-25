class MaxEffect{
    
    color[] palette;
    PVector[] paletteV;
    float scl = 25;
    color col;
    float tol = 15;
    int tiVid = 0;
    
    MaxEffect() {
        palette = new color[0];
        paletteV = new PVector[0];
    }
    
    void postBuffer_pixelArt(PGraphics cam, int indexVideo) {
        videoNext(indexVideo);
        cam.loadPixels();
        
        for (int y = 0; y < cam.height; y += scl) {
            for (int x = 0; x < cam.width; x += scl) {
                int index = x + y * cam.width;               
                color col = palette(rgb_XYZ(cam.pixels[index]),cam.pixels[index]);
                noStroke();
                fill(col);
                rect((x - scl / 2),(y - scl / 2), scl * 2, scl * 2);
            }
        }
        
        //---------------DEBUG purpose only-------------------------
        int c = 0;
        int l = 0;
        for (int i = 0; i < palette.length; i++) {//display palette
            
            if (40 * i + 60 - c > height) {
                c += height - 40;
                l += 40;
            }
            fill(palette[i]);
            rect(20 + l,20 + 40 * i - c, 40, 40);
        }
        //----------------------------------------------------------
    }
    
    void videoNext(int iVid) {
        if (tiVid!= iVid) {       
            palette = new color[0];
            paletteV = new PVector[0]; 
            tiVid = iVid;
        }          
    }
    
    PVector rgb_XYZ(color trgb) {
        float R = red(trgb) / 255;
        float G = green(trgb) / 255;
        float B = blue(trgb) / 255;
        
        if (R > 0.04045)R = pow((R + 0.055) / 1.055, 2.4);
        else R = R / 12.92;
        
        if (G > 0.04045)G = pow((G + 0.055) / 1.055, 2.4);
        else G = G / 12.92;
        
        if (B > 0.04045)B = pow((B + 0.055) / 1.055, 2.4);
        else B = B / 12.92;
        
        R *=  100;
        G *=  100;
        B *=  100;
        
        float X = R * 0.4124 + G * 0.3576 + B * 0.1805;
        float Y = R * 0.2126 + G * 0.7152 + B * 0.0722;
        float Z = R * 0.0193 + G * 0.1192 + B * 0.9505;
        
        PVector vXYZ = new PVector(X, Y, Z);
        
        return vXYZ;
    }
    
    color palette(PVector vCol, color cCol) {
        float diffmin = -1;
        if (paletteV.length ==  0) {
            palette = append(palette, cCol);
            paletteV = (PVector[])append(paletteV, rgb_XYZ(cCol));
        }
        
        for (int i = 0; i < palette.length; i++) {
            
            float diff = PVector.dist(vCol, paletteV[i]);
            
            if (diff < diffmin || diffmin == -1) {
                diffmin = diff;
                col = palette[i];
            }
        }
        if (diffmin > tol) {
            palette = append(palette, cCol);
            paletteV = (PVector[])append(paletteV, rgb_XYZ(cCol));
            col = cCol;
        }
        return(col);
    }
    
    
    void mouseWheel(MouseEvent event) {
        if (scl >= 2) {
            scl += event.getCount();
            scl = constrain(scl, 2, 100);
            println("scl=", scl);
        }
    }
}