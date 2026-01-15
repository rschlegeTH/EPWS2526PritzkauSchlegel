@tool
class_name PlayEffect extends RichTextEffect
var label:RichTextLabel
var bbcode := "playEffect"

func _process_custom_fx(char_fx: CharFXTransform):
	
	var hue := char_fx.range.x / 20.0
	char_fx.color = Color.from_hsv(hue + char_fx.elapsed_time * 0.5, (-label.temp.productivity * 0.01 + 1.0), 1.0)
	
	var bounce := pow((fmod(6.0 * char_fx.elapsed_time + char_fx.range.x / 4.0, 4.0) - 2.0), 2.0) / 4.0
	char_fx.offset.y = 24.0 * bounce * (-label.temp.productivity * 0.01 + 1.0) - 24.0 * (-label.temp.productivity * 0.01 + 1.0)
	
	
