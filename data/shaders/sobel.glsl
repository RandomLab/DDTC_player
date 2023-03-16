#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 iResolution;

uniform float dec=0.5;

float grey(vec2 uv){
  vec3 c = texture(texture, uv).rgb;
  return (c.r + c.g + c.b) / 3.;
    
  float aspect = iResolution.x / iResolution.y;
  vec2 aspect2 = vec2(aspect, 1.);
	return smoothstep(.5, .4, length(uv * aspect2 + - .5));
}


float sobel_vertical(vec2 uv){
    vec2 p = 1. / iResolution.yy;
    
    float top = grey(uv - vec2(0, p.y));
    float topleft = grey(uv - vec2(-p.x, p.y));
    float topright = grey(uv + p);
    float bottom = grey(uv + vec2(0, p.y));
    float bottomleft = grey(uv + vec2(-p.x, -p.y));
    float bottomright = grey(uv + vec2(p.x, -p.y));
    
    float c = bottomleft + bottomright + 2. * bottom - topleft - topright - 2. * top;
    return c * dec + dec;
}

void main(void) {

	vec2 uv = gl_FragCoord.xy / iResolution.xy;
  vec3 col = vec3(0);
    
  //float t = sin(iTime) * .2 + .5;
    //float tl = t - .2;
    //float tr = t + .2;
    
    //float l = smoothstep(tl - .005, tl + .005, uv.x);
    //float r = smoothstep(tr + .005, tr - .005, uv.x);
    
	//col += grey(uv);
    //col += laplace(uv);
  col += sobel_vertical(uv);

	col *= vec3(1.0, 1.1, 1.0);

	if(col.r > 0.9){
		col.b = 0.0;
	}

  gl_FragColor = vec4(col, 1.0);  
}


/*
float grey(vec2 uv)
{
    vec3 c = texture(iChannel0, uv).rgb;
    return (c.r + c.g + c.b) / 3.;
    
    float aspect = iResolution.x / iResolution.y;
    vec2 aspect2 = vec2(aspect, 1.);
	return smoothstep(.5, .4, length(uv * aspect2 + - .5));
}

float laplace(vec2 uv)
{
    vec2 pixel = 1. / iResolution.yy;
    
	float center = grey(uv);
    float left = grey(uv - vec2(pixel.x, 0));
    float right = grey(uv + vec2(pixel.x, 0));
    float up = grey(uv - vec2(0, pixel.y));
    float down = grey(uv + vec2(0, pixel.y));
    
    float c = left + right + up + down - 4. * center;
    return c * .5 + .5;
}

float sobel_vertical(vec2 uv)
{
    vec2 p = 1. / iResolution.yy;
    
    float top = grey(uv - vec2(0, p.y));
    float topleft = grey(uv - vec2(-p.x, p.y));
    float topright = grey(uv + p);
    float bottom = grey(uv + vec2(0, p.y));
    float bottomleft = grey(uv + vec2(-p.x, -p.y));
    float bottomright = grey(uv + vec2(p.x, -p.y));
    
    float c = bottomleft + bottomright + 2. * bottom - topleft - topright - 2. * top;
    return c * .5 + .5;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    vec3 col = vec3(0);
    
    //float t = sin(iTime) * .2 + .5;
    //float tl = t - .2;
    //float tr = t + .2;
    
    //float l = smoothstep(tl - .005, tl + .005, uv.x);
    //float r = smoothstep(tr + .005, tr - .005, uv.x);
    
    //col += grey(uv);
    //col += laplace(uv);
    col += sobel_vertical(uv);
        
    
    fragColor = vec4(col, 1.);
}
*/