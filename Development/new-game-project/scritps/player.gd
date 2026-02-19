extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim := $AnimatedSprite2D
@onready var vMan := %"Variablen-Manager"

func _process(_delta: float) -> void:
	if((vMan.stress > 50) && (vMan.gesundheit < 50)):
		anim.play("tired and stressed")
		if((vMan.stress > 80) && (vMan.gesundheit < 20)):
			anim.play("max tired and max stressed")
		elif ((vMan.stress > 80) && (vMan.gesundheit < 50)):
			anim.play("tired and max stressed")
		elif ((vMan.stress > 50) && (vMan.gesundheit < 20)):
			anim.play("max tired and stressed")
	elif(vMan.stress > 50):
		anim.play("stressed")
		if(vMan.stress > 80):
			anim.play("max stressed")
	elif(vMan.gesundheit < 50):
		anim.play("tired")
		if(vMan.gesundheit < 20):
			anim.play("max tired")
	else:
		anim.play("default")
func _physics_process(_delta: float) -> void:
	#Sollte gerade Dialog ausgeführt werden, darf der Spieler sich nicht bewegen.
	if(vMan.text_active):
		return
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if(direction > 0):
			anim.flip_h = true
		else:
			anim.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var vertDirection := Input.get_axis("ui_up", "ui_down")
	if vertDirection:
		velocity.y = vertDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
