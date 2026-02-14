extends Sprite2D

const lines: Array[String] = [
	"test 1asd",
	"BEN Pritz, von der Kau, ist so super, der ist toll.",
	"test 3",
]
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && !DialogManager.is_dialog_active:
		DialogManager.start_dialog((global_position), lines)
