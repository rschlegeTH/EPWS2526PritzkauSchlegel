extends Button
@onready var vMan = %"Variablen-Manager"

func _on_pressed() -> void:
	vMan.workButton()
