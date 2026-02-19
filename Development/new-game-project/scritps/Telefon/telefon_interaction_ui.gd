extends Node2D

var playerInArea: bool = false
var callAvailable: bool = false
@onready var ui := $"Telefon/Area2D/TelefonInteractionUI"
@export var vMan : Node

@onready var ring1 := $Ring1

## Eine Array-Zelle beschreibt eine Textbox.
@export_multiline var lines: Array[String] = [
	"???: Hallo, Lina? Bist du dran? ",
	"Lina: Ja, Lina hier. Wer ist denn da?",
	"???: Ich bins, Nina! Wir haben doch zusammen unser Entwicklungsprojekt!",
	"Lina: Ah, ich erinnere mich. Was gibt es denn?",
	"Nina: Du, hast du schon deine Aufgaben für das nächste Audit fertig?",
	"Lina: Nein, das habe ich total vergessen! Was mach ich denn jetzt?!",
	"Nina: Keine Sorge! Du schafst das! Ich kann dir leider nicht helfen, da ich mit meiner Familie Unterwegs bin. ",
	"Lina: ...",
	"Nina: Ok, ich weiß, dass das jetzt nicht leicht wird, aber du musst das alleine fertig machen. Wenn du das schaffen willst, musst du auf deine Gesundheit achten!",
	"Nina: Die ganze Zeit an so einem Projekt zu machen, macht dich doch nur krank.", 
	"Nina: Und nimm dir regelmäßig Pausen, um deinen Hobbys nachzugehen und zu schlafen, sonst gehst du noch im Stress unter!",
	"Lina: Das weiß ich doch selber!",
	"Nina: Wie dem auch sei. Gib auf dich acht und bitte mach das Projekt fertig. Ohne deinen Part sind wir aufgeschmissen!",
	"Lina: Ok, ich gebe mein bestes!",
	"Nina: Okay, dann viel Erfolg! Bis dann.",
	"Lina: Danke, bis dann.",
	"*Piep*, *piep*, *piep*",
]
@export_multiline var lines2: Array[String] = ["lines 2"]

@export_multiline var lines3: Array[String] = ["lines 3"]

var current_lines: Array[String] = [""]
var current_call : int = 0

func _process(_delta: float) -> void:
	if vMan:
		if (vMan.time_Hour > 8) && (vMan.dead == 1) && (callAvailable == false) && current_call == 0:
			print(vMan.time_Hour + vMan.dead)
			current_call = 1
			current_lines = lines
			callAvailable = true
			ring1.toggle(true)
		elif (vMan.time_Hour > 8) && (vMan.dead == 2) && (callAvailable == false) && current_call == 2:
			current_lines = lines2
			callAvailable = true
			ring1.toggle(true)
		elif (vMan.time_Hour > 8) && (vMan.dead == 4) && (callAvailable == false) && current_call == 3:
			current_lines = lines3
			callAvailable = true
			ring1.toggle(true)



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && !DialogueManager.is_dialogue_active && playerInArea:
		DialogueManager.show_text(current_lines)
		if(current_call < 4 && callAvailable):
			_next_dialogue()
		callAvailable = false
		ring1.toggle(false)

func _next_dialogue():
	current_call = current_call + 1
	current_lines = [""]

func _on_area_2d_body_entered(_body: Node2D) -> void:
	playerInArea = true
	ui.show()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	playerInArea = false
	ui.hide()
