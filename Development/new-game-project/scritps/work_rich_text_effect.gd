@tool
class_name WorkEffect extends RichTextEffect
var label:RichTextLabel
var bbcode := "workEffect"

func _process_custom_fx(char_fx: CharFXTransform):
	
	char_fx.color.g = label.temp.gesundheit/100
	
	
