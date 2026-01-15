extends RichTextLabel


var sleep_effect:SleepEffect
@onready var temp = %"Variablen-Manager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sleep_effect = SleepEffect.new()
	sleep_effect.label = self
	install_effect(sleep_effect)
