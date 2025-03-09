shader_type canvas_item;

uniform vec3 mask_color : source_color = vec3(0.0, 0.0, 0.0);
uniform float threshold : hint_range(0.0, 1.0, 0.01) = 0.0;

vec2 cartesian_to_polar(vec2 uv) {
	uv -= vec2(0.5);
	return vec2(length(uv), (atan(uv.y, uv.x) + PI) / TAU);
}

// length(r)
// [0, 1]

void fragment() {
	vec2 uv = cartesian_to_polar(UV);
	float mask = step(threshold, uv.y);
	COLOR.rgb *= mix(vec3(1.0), mask_color, mask);
}
