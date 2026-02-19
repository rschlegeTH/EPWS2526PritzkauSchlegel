shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE:hint_screen_texture;
uniform float intensity : hint_range(0,1) = 0.0;

void fragment() {
	COLOR.rgb = vec3(0.0, 0.0, 0.0);
	
	vec2 center = vec2(0.5, 0.5);
	vec2 vec = UV - center;
	
	float angle = atan(vec.y, vec.x) / (2.0*PI) + 0.5;
	
	float progress = step(angle, intensity);
	COLOR.a *= progress;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
