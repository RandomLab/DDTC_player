#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertTexCoord;
uniform sampler2D texture;
uniform vec3 iResolution;
uniform float iGlobalTime;

float rand(vec2 co){
	return fract(cos(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(){
	vec3 uv = vec3(0.0);
	vec2 uv2 = vec2(0.0);
	vec2 nuv = gl_FragCoord.xy / iResolution.xy;
	vec3 texColor = vec3(0.0);


	float r = rand(vec2(iGlobalTime * 0.001));
	float r2 = rand(vec2(iGlobalTime * 0.1));
			 
	uv.r -= sin(nuv.x * r * 0.1 * iGlobalTime ) * r;
	uv.g += sin(vertTexCoord.y * vertTexCoord.x/2 * 0.006 * iGlobalTime) * r * 10 *rand(vec2(iGlobalTime * 0.1)) ;
	uv.b -= sin(nuv.y * nuv.x * 0.5 * iGlobalTime) * sin(nuv.y * nuv.x * 0.1) * r ;
	uv2 += vec2(sin(nuv.x * r * 0.1 * iGlobalTime ) * r );


	texColor = texture2D(texture, vertTexCoord.st).rgb;
	//texColor += uv;
	gl_FragColor = vec4(texColor, 1.0);  
	 
}