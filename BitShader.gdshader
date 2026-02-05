shader_type canvas_item;

global uniform vec4 Red;
global uniform vec4 Blue;
global uniform vec4 Green;

void fragment() {
	// Capture texture
	vec4 c = texture(TEXTURE, UV);
	vec3 new1 = mix(c.rgb, Green.rgb, c.g);
	vec3 new2 = mix(new1.rgb, Blue.rgb, c.b);
	vec3 new3 = mix(new2.rgb, Red.rgb, c.r);
	COLOR.rgb = new3.rgb;
	COLOR.a = c.a;
}