@tool
class_name SleepEffect extends RichTextEffect
var label:RichTextLabel
var bbcode := "sleepEffect"

func _process_custom_fx(char_fx: CharFXTransform):
	var tSSleep:float = clampf(label.vMan.ticksSinceSleep, 0, 130)
	if(tSSleep>30):
		char_fx.color.a = clampf((tSSleep)/100, 0, 1)
	else:
		char_fx.color.a = 0.3
	
	
