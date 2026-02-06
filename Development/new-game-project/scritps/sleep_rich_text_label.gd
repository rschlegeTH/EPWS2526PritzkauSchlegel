extends RichTextLabel


var sleep_effect:SleepEffect
@onready var temp = %"Variablen-Manager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sleep_effect = SleepEffect.new()
	sleep_effect.label = self
	install_effect(sleep_effect)


func _on_bett_area_2d_body_entered(body: Node2D) -> void:
	$".".show()
	temp.interactionObject = 1
	



func _on_bett_area_2d_body_exited(body: Node2D) -> void:
	$".".hide()
	temp.interactionObject = 0
