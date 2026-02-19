extends Node

## Textbox-Szene
const TEXTBOX = preload("res://scritps/DialogRPGStyle/textbox.tscn")

var is_dialogue_active = false
var vMan:Node # Variablen Manager
## Übergebenen Text in einer Textbox ausgeben.
func show_text(lines: Array[String]):
	
	# Optional: Verhindern, dass zwei Boxen gleichzeitig entstehen
	if is_dialogue_active:
		return
	
	# Textbox-Instanz erzeugen
	var textbox_instance = TEXTBOX.instantiate()
	
	# Textbox-Instanz In den Tree einfügen
	# Wir fügen es zu 'root' hinzu, damit es über allem liegt, auch beim Szenenwechsel
	get_tree().root.add_child(textbox_instance)
	
	# Der Textbox-Instanz den Text übergeben und starten
	textbox_instance.start(lines)
	
	# Aktivität des Dialogs vermerken
	is_dialogue_active = true
	if vMan:
		vMan.text_active = is_dialogue_active
	# Verbeinden des "tree_exited" Signal, um zu wissen, wann die Box weg ist
	textbox_instance.tree_exited.connect(_on_textbox_closed)

func _on_textbox_closed():
	is_dialogue_active = false
	if vMan:
		vMan.text_active = is_dialogue_active
	print("Dialog beendet")
	
