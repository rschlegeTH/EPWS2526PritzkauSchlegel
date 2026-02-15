extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

var tween: Tween 

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

# Textbox nicht sichtbar
func _ready():
	hide_textbox()

# Dialog mit übergebenen Text starten(DialogueManager)
func start(lines: Array[String]):
	text_queue.clear()
	for line in lines:
		text_queue.push_back(line)
	
	display_text()

func _process(_delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
			else:
				# WICHTIG: Wenn keine Texte mehr da sind, wird die ganze Instanz gelöscht
				queue_free()
				
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				if tween:
					tween.kill()
				end_symbol.text = "v"
				change_state(State.FINISHED)
				
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_ratio = 0.0
	change_state(State.READING)
	show_textbox()
	
	# Alte Tween-Daten werden entfernt.
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
	tween.finished.connect(_on_tween_finished)

func change_state(next_state: State):
	current_state = next_state

func _on_tween_finished():
	end_symbol.text = "v"
	change_state(State.FINISHED)
