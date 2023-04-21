#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;

//[const,width,height]
uniform vec2 iResolution; // iResolution in Shadertoy
//[slider,1,32]
uniform float colorBits = 8.;
//[slider,1,64]
uniform int pixelSize = 16;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	const int multiSample = 2;
	float pixelSizeI= float(pixelSize); 

	vec2 uv = (floor(fragCoord.xy / pixelSizeI) * pixelSizeI) / iResolution.xy;
	vec4 color = vec4(0, 0, 0, 0);
	for (int x = 0; x < multiSample; x++) {
		for (int y = 0; y < multiSample; y++) {
			color += texture(texture, uv + (vec2(x, y) / iResolution.xy));
		}
	}
	color /= float(multiSample * multiSample);
	color = floor(color * colorBits) / colorBits;
	fragColor = color;
}

void main() {
	mainImage(gl_FragColor, gl_FragCoord.xy);
}