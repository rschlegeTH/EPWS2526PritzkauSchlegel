extends RichTextLabel

var work_effect:WorkEffect
@onready var temp = %"Variablen-Manager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	work_effect = WorkEffect.new()
	work_effect.label = self
	install_effect(work_effect)


func _on_area_2d_body_entered(body: Node2D) -> void:
	$".".show()
	temp.interactionObject = 3


func _on_area_2d_body_exited(body: Node2D) -> void:
	$".".hide()
	temp.interactionObject = 0
