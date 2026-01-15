extends Label

@onready var temp = %"Variablen-Manager"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$".".text = str(temp.time_Hour).pad_zeros(2) + ":" + str(temp.time_Minutes).pad_zeros(2) # Schreib den wert von stress auf das Lable
