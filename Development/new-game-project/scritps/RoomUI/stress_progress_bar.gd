extends ProgressBar
@onready var vMan := %"Variablen-Manager"
@onready var sb := StyleBoxFlat.new()
func _ready() -> void:
	add_theme_stylebox_override("fill", sb)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$".".value =vMan.stress
	sb.bg_color = Color(vMan.stress/100, (-vMan.stress + 100)/100, 0)
	
