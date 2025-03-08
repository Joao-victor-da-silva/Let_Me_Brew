shader_type canvas_item;

uniform vec4 shield_color : source_color;
uniform float blink_speed : hint_range(0.0, 16.0, 0.1) = 4.0;

float circle(vec2 position, float radius, float feather) {
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
	float outer = circle(vec2(UV.x, UV.y), 0.45, 0.01);
	float fade_effect = sin(TIME * blink_speed) * 0.01;
	float inner = 1.0 - circle(vec2(UV.x, UV.y), 0.375, 0.1 - fade_effect);
	COLOR = shield_color;
	COLOR.a -= outer + inner;
}
