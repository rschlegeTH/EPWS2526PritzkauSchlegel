@tool
class_name SleepEffect extends RichTextEffect
var label:RichTextLabel
var bbcode := "sleepEffect"

func _process_custom_fx(char_fx: CharFXTransform):
	if(label is RichTextLabel):
		char_fx.color.g = label.temp.gesundheit/100
		
	
