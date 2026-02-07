extends Polygon2D
@onready var vMan = %"Variablen-Manager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (vMan.calcEnding() == 0):
		return
	$".".show()
