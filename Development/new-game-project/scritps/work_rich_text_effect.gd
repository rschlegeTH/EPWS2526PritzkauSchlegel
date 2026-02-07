@tool
class_name WorkEffect extends RichTextEffect
var label:RichTextLabel
var bbcode := "workEffect"

func _process_custom_fx(char_fx: CharFXTransform):
	
	char_fx.color = Color.from_hsv(1.0, 0.0, label.vMan.productivity * 0.009 + 0.1)
	
	
