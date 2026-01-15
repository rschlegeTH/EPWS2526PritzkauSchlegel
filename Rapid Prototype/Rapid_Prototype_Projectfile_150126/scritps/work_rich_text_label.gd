extends RichTextLabel

var work_effect:WorkEffect
@onready var temp = %"Variablen-Manager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	work_effect = WorkEffect.new()
	work_effect.label = self
	install_effect(work_effect)
