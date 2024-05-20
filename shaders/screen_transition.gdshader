shader_type canvas_item;

uniform sampler2D wipe_image;
uniform float percentage : hint_range(0.0, 1.0);

void fragment() {
	float pixel_value = texture(wipe_image, UV).r;
	if(pixel_value > percentage){
		COLOR.a = 0.0;
	}
}