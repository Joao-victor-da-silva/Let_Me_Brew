shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flash_amount : hint_range(0.0, 1.0, 0.01) = 0.0;

void fragment() {
	vec3 color = texture(TEXTURE, UV).rgb;
	COLOR.rgb = mix(color, flash_color.rgb, flash_amount);
}
