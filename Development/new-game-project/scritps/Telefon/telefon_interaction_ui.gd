extends Node2D

var playerInArea: bool = false
var callAvailable: bool = false
@onready var ui = $"Arbeitsplatz2/Area2D/TelefonInteractionUI"

## Eine Array-Zelle beschreibt eine Textbox.
@export_multiline var lines: Array[String] = [
	"test 1asd",
	"BEN Pritz, von der Kau, ist so super, der ist toll.",
	"test 3",
]
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && !DialogManager.is_dialog_active && playerInArea:
		DialogManager.start_dialog((global_position), lines)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	playerInArea = true
	ui.show()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	playerInArea = false
	ui.hide()
