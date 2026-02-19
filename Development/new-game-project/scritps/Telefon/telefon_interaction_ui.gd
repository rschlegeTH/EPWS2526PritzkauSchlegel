extends Node2D

var playerInArea: bool = false
var callAvailable: bool = false
@onready var ui = $"Telefon/Area2D/TelefonInteractionUI"

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
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && !DialogueManager.is_dialogue_active && playerInArea:
		DialogueManager.show_text(lines)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	playerInArea = true
	ui.show()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	playerInArea = false
	ui.hide()
