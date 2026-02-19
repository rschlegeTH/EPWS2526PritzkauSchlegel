extends Sprite2D
@onready var vMan := %"Variablen-Manager"

var shader_intensity: float = 0.0
var sleep_finished := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(vMan.sleep_shader):
		shader_intensity = clampf(shader_intensity + 1.5 * delta, 0.0, 1.0)
		print(shader_intensity)
		$".".material.set_shader_parameter("intensity", shader_intensity)
	else:
		shader_intensity = clampf(shader_intensity - 1.5 * delta, 0.0, 1.0)
		$".".material.set_shader_parameter("intensity", shader_intensity)
	if shader_intensity == 1.0 && vMan.sleep_shader:
		print("sleepShader Done!")
		vMan.sleep_shader = false
		vMan.sleep()
