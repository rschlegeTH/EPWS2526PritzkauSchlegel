extends RichTextLabel

var play_effect:PlayEffect
@onready var vMan = %"Variablen-Manager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_effect = PlayEffect.new()
	play_effect.label = self
	install_effect(play_effect)


func _on_area_2d_body_entered(body: Node2D) -> void:
	$".".show()
	vMan.interactionObject = 2


func _on_area_2d_body_exited(body: Node2D) -> void:
	$".".hide()
	vMan.interactionObject = 0
