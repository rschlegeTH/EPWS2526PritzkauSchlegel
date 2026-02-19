extends Label
@onready var temp = %"Variablen-Manager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (temp.calcEnding() <= 1):
		$".".text = "Du hast nicht all deine Aufgaben innerhalb der Deadline erfüllt!"
		return
	$".".text = "Du hast all deine Aufgaben innerhalb der Deadline erfüllt!"
