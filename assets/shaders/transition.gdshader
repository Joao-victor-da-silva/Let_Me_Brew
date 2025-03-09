shader_type canvas_item;

uniform sampler2D gradient_texture;
uniform float threshold : hint_range(0.0, 1.0, 0.01) = 0.0;

void fragment() {
	float value = 1.0 - texture(gradient_texture, UV).r;
	COLOR.a = step(1.0 - threshold, value);
}
