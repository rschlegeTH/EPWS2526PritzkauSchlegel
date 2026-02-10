extends PanelContainer

var opacity_tween: Tween = null
@export_multiline var text: String = ""
@onready var label = $RichTextLabel
const OFFSET := Vector2(-225, 25)
func _ready() -> void:
	hide()
	label.text = text
	
func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + OFFSET

func tween_opacity(to: float):
	if opacity_tween: opacity_tween.kill()
	opacity_tween = get_tree().create_tween()
	opacity_tween.tween_property(self, 'modulate:a', to, 0.3)
	return opacity_tween

func toggle(on: bool):
	if on: 
		show()
		modulate.a = 0.0
		tween_opacity(1.0)
	else:
		modulate.a = 1.0
		await tween_opacity(0.0).finished
		hide()
