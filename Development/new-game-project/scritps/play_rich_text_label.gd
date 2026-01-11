extends RichTextLabel


var play_effect:PlayEffect
@onready var temp = %"Variablen-Manager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_effect = PlayEffect.new()
	play_effect.label = self
	install_effect(play_effect)
