extends Node2D

var playerInArea: bool = false
var callAvailable: bool = false
@onready var ui := $"Telefon/Area2D/TelefonInteractionUI"
@export var vMan : Node

@onready var ring1 := $Ring1

## Eine Array-Zelle beschreibt eine Textbox.
@export_multiline var lines: Array[String] = [
	"???: Heya, Lisa? Bist du dran? ",
	"Lisa: Ja, Lisa hier. Wer ist denn da?",
	"???: Ich bins, Ken! Wir haben doch zusammen unser Entwicklungsprojekt!",
	"Lisa: Ah, ich erinnere mich. Was gibt es denn?",
	"Ken: Du, hast du schon deine Aufgaben für das nächste Audit fertig?",
	"Lisa: Nein, das habe ich total vergessen! Was mach ich denn jetzt?!",
	"Ken: Keine Sorge! Du schafst das! Ich kann dir leider nicht helfen, da ich mit meiner Familie Unterwegs bin. ",
	"Lisa: ...",
	"Ken: Ok, ich weiß, dass das jetzt nicht leicht wird, aber du musst das alleine fertig machen. Wenn du das schaffen willst, musst du auf deine Gesundheit achten!",
	"Ken: Die ganze Zeit an so einem Projekt zu arbeiten, macht dich doch noch krank.", 
	"Ken: Und nimm dir regelmäßig Pausen, um deinen Hobbys nachzugehen und zu schlafen, sonst gehst du noch im Stress und Krankheit unter!",
	"Lisa: Das weiß ich doch selber!",
	"Ken: Wie dem auch sei. Gib auf dich acht und bitte mach das Projekt fertig. Ohne deinen Part sind wir aufgeschmissen!",
	"Lisa: Ok, ich gebe mein bestes!",
	"Ken: Okay, dann viel Erfolg! Bis dann.",
	"Lisa: Danke, bis dann.",
	"*Piep*, *piep*, *piep*",
]
@export_multiline var lines2: Array[String] = [
	"Ken: Heya! Ich bins wieder.",
	"Lisa: Aha, was ist los? Hast du was vergessen?",
	"Ken: Nee, wollte nur noch mal nachfragen wie es läuft?",
	"Lisa: Naja, also eigentlich ist das Projekt ziemlich anstrengend und ich habe angst, dass ich es nicht rechtzeitig schaffe!",
	"Ken: Immer nur die Ruhe bewahren. Geh einfach regelmäßig schlafen, nimm dir Pausen und arbeite nicht zu viel auf einmal am Projekt.",
	"Lisa: Meinst du das hilft?",
	"Ken: Aber natürlich! Bei Projekten geht es um korrektes Zeitmanagement. Es ist ein Marathon und nicht ein Wettrennen.",
	"Lisa: Okay, ich versuchs..",
	"Ken: Okay, ich muss jetzt los. Viel Erfolg dir noch und bis dann!",
	"Lisa: Bis dann!",
	"*Piep*, *piep*, *piep*",
	]

@export_multiline var lines3a: Array[String] = [
	"Ken: Heya, da bin ich wieder!",
	"Lisa: Ken.........",
	"Ken: Ja, bitte?",
	"Lisa: Ich glaube es ist aus...",
	"Lisa: Ich werde es nicht schaffen...",
	"Ken: Was ist denn passiert?",
	"Lisa: Es war einfach zu viel, ich habe nicht genug am Projekt gearbeitet und wenn ich dran war, kam einfach nichts bei rum.",
	"Ken: ...",
	"Lisa: ...",
	"Ken: Dann müssen wir es nächstes Jahr wohl erneut versuchen.",
	"Lisa: Es tut mir leid. Ich werds wieder gut machen, versprochen.",
	"Ken: Alles gut, ich muss eh noch ein paar Module nachholen. Und solange du an deinem Zeitmanagement arbeitest, können wir es nöchstes mal wieder versuchen.",
	"Lisa: Dankschön, wir sehen uns dann nächste Woche?",
	"Ken: Ja, dann bis dann.",
	"Lisa: Bis dann.",
	"*Piep*, *piep*, *piep*",
	]

@export_multiline var lines3b: Array[String] = [
	"Ken: Heya, da bin ich wieder!",
	"Lisa: Hey Ken, was gibts?",
	"Ken: Wollte nur gucken, ob du gut klarkommst?",
	"Lisa: Ja, ich denke ich werde noch gerade so durchkommen. Wir sollten, solange es noch so weitergeht, durchkommen.",
	"Ken: Das klingt doch gut! Dann kann ich dich ja so weiter machen lassen.",
	"Lisa: Ja, das passt schon.",
	"Ken: Gut, ich sollte in paar Tagen wieder zurück sein. Ich gebe dir dann einen aus!",
	"Lisa: Gut, dann bis dann!",
	"*Piep*, *piep*, *piep*",
	]

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
			if vMan.completion > 70:
				current_lines = lines3b
			else:
				current_lines = lines3a
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
