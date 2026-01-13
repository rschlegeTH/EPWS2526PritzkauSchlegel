extends Label
@onready var temp = %"Variablen-Manager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (temp.calcEnding() <= 1):
		$".".text = "You Lost!"
		return
	$".".text = "You Won!!"
