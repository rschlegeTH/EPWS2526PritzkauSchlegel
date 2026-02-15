extends MarginContainer

@onready var label = $MarginContainer/RichTextLabel
@onready var timer = $LetterDisplayTimer

const MAX_WIDTH = 256

var text = ""
var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	text = text_to_display
	label.text = text_to_display
	letter_index = 0
	
	# SCHRITT 1: Reset
	# Wir erlauben der Box erst einmal, so groß oder klein zu sein, wie sie will.
	# Autowrap AUS, damit wir die wahre Länge der Zeile messen können.
	custom_minimum_size.x = 0
	custom_minimum_size.y = 0
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	
	# Größe auf 0 setzen, damit der Container auf den Inhalt schrumpft/wächst
	size = Vector2.ZERO 
	
	# Einen Frame warten, damit Godot die "natürliche" Breite berechnet
	await get_tree().process_frame
	
	# SCHRITT 2: Prüfen und Limitieren
	if size.x > MAX_WIDTH:
		# Der Text ist zu lang! Wir erzwingen den Umbruch.
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		custom_minimum_size.x = MAX_WIDTH
		# Jetzt warten wir noch einen Frame, damit Godot den Umbruch 
		# berechnet und die neue HÖHE (Y) festlegt.
		await get_tree().process_frame
	
	# (Falls der Text kurz ist, bleibt Autowrap aus und size.x ist klein -> alles gut)

	# SCHRITT 3: Positionierung (Dein Code mit Kamera-Fix)
	var target_world_pos = global_position 
	target_world_pos.x -= size.x / 2
	target_world_pos.y -= size.y + 24
	
	var canvas_transform = get_canvas_transform()
	var target_screen_pos = canvas_transform * target_world_pos
	var screen_box_size = size * canvas_transform.get_scale()
	var screen_rect = get_viewport_rect()
	var margin = 10 
	
	target_screen_pos.x = clamp(target_screen_pos.x, margin, screen_rect.size.x - screen_box_size.x - margin)
	target_screen_pos.y = clamp(target_screen_pos.y, margin, screen_rect.size.y - screen_box_size.y - margin)
	
	global_position = canvas_transform.affine_inverse() * target_screen_pos
	
	label.text = ""
	_display_letter()

func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)


func _on_letter_display_timer_timeout() -> void:
	_display_letter()
