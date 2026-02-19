extends PanelContainer

@export var mouse_mode:= true
@export var is_visible := false
var opacity_tween: Tween = null
@export_range(0.0, 1.0) var duration : float = 0.3
@export_multiline var text: String = ""
@onready var label = $RichTextLabel
const OFFSET := Vector2(-225, 25)
func _ready() -> void:
	if(is_visible):
		show()
	else:
		hide()
	label.text = text
	
	
func _input(event: InputEvent) -> void:
	if mouse_mode and visible and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + OFFSET

func tween_opacity(to: float):
	if opacity_tween: opacity_tween.kill()
	opacity_tween = get_tree().create_tween()
	opacity_tween.tween_property(self, 'modulate:a', to, duration)
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
