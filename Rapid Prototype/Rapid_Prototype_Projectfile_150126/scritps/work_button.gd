extends Button
@onready var temp = %"Variablen-Manager"

func _on_pressed() -> void:
	temp.workButton()
