shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE:hint_screen_texture;
uniform float intensity : hint_range(0,1) = 0.0;

vec4 multiply(vec4 base, vec4 blend){
	return base * blend;
}

vec4 color_dodge(vec4 base, vec4 blend){
	return base / (1.0 - blend);
}

vec4 shift_hue(vec4 color, float shift){
	vec3 gray = vec3(0.57735);
	vec3 projection = gray * dot(gray, color.rgb);
	vec3 U = color.rgb - projection;
	vec3 V = cross(gray, U);
	vec3 shifted = U * cos(shift * 2.0 * PI) + V * sin(shift * 2.0 * PI) + projection;
	return vec4(shifted, color.a);
}

void fragment() {
	vec4 changingColor = shift_hue(COLOR, mod(TIME, 5.0) / 5.0);
	
	vec4 bg_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec4 temp = multiply(bg_color, changingColor);
	
	COLOR.rgb = mix(bg_color, color_dodge(mix(bg_color, temp, 0.5), changingColor), intensity).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
