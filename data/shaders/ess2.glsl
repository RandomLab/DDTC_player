#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertTexCoord;
uniform sampler2D texture;

uniform vec2 u_resolution;
uniform float u_time;

void main(){
	vec2 coord = 6.0 * gl_FragCoord.xy / u_resolution;

	for (int n = 1; n < 3; n++){
		float i = float(n);
		coord += vec2(1.7 / i * sin(i * coord.y + u_time*0.1 + 0.3 * i) + 0.8, 6.4 / i * sin(coord.x + u_time*0.1 + 0.3 * i) + 1.6);
	}

	coord *= vec2(0.4 / sin(coord.y + u_time + 0.3) + 0.8, 0.4 / sin(coord.x + u_time + 0.3) + 0.6);
	vec3 color = vec3(1.5 * sin(coord.x) + 0.5, 0.0 * sin(coord.y) + 0.5, sin(coord.x + coord.y)+ 0.2);
	
	vec3 texColor = texture2D(texture, vertTexCoord.st*color.x).rgb;

	vec3 mix = (color*0.05)+texColor*0.5;
	
	gl_FragColor = vec4(mix, 1.0);

}