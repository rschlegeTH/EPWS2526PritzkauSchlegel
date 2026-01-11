@tool
class_name PlayEffect extends RichTextEffect
var label:RichTextLabel
var bbcode := "playEffect"

func _process_custom_fx(char_fx: CharFXTransform):
	if(label is RichTextLabel):
		char_fx.color.g = label.temp.gesundheit/100
		
	
