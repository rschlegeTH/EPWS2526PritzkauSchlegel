extends Label
@onready var vMan = %"Variablen-Manager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (vMan.calcEnding() <= 1):
		$".".text = "You Lost!"
		return
	$".".text = "You Won!!"
