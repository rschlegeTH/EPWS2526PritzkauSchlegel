extends Node
var gesundheit: float = 100 #Gesundheit

var stress: float = 0

var productivity: float = 100 #Produktivität

var completion: int = 0 #Arbeitsfortschritt
# Zeit

# Deadline-Segment der Zeit
var dead: int = 1 #verbleibende Zeit zur deadline, zählt aufwärts
var deadline: int = 6
var deadMult: float = 0.5
# Zeit muss gezeitet werden

# Zeit seit Schlaf
var timeOfLastSleep: float = Time.get_unix_time_from_system() # Standardwerte mit Unix_Time, sollte aber evtl mit engine Time gemacht werden?
var elapsedTimeSinceSleep: float # Standardwerte

var sDiv: float = 100 #standerdDivider, wird für Beeinflussung der Rechnungeng verwendet und beeinflusst das Kurvenverhalten.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	calcElapsedTimeSinceSleep()

func calcGes() -> void:
	var g_mod = 0 # Gesundheits_Modifikitor, also der Wert, um den die Gesundheit verändert wird
	var erhöhung = 0.1 # Wachtum der Kurve
	if(timeOfLastSleep < 60):
		g_mod = tanh((stress)/sDiv)
	else:
		g_mod = tanh(stress)/sDiv + tanh((timeOfLastSleep-60)* erhöhung)
	g_mod = clampf(g_mod, 0, 1) #Ist 1 ein guter Wert für einen Clamp?
	gesundheit = gesundheit - g_mod
	
func calcStress() -> void:
	var s_mod:float = (-gesundheit)/sDiv + ((-completion+100) * dead)/sDiv #deadline Wert(dead) beobachten
	s_mod = clampf(s_mod, -1, 1)
	stress = stress + s_mod

func addCompletion() -> void:
	var minVal = 0
	var maxVal = 100
	var completionGrowth = 1
	completion = clamp( completionGrowth, minVal, maxVal)
#Produktivitäsparameter berechnen
func calcProductitvity(): # Überarbeiten??? Berechnet die Produktivität, Formel könnte überarbeitet werden
	var localDivider = 2 # Wert um Stresswert auf die Hälfte zu limitieren
	productivity = clampf(gesundheit - stress / localDivider, 0, 100)
	

func workButton () -> void:
	print("work")
func sleepButton () -> void:
	print("sleep")
func gameButton () -> void:
	print("game")

func calcElapsedTimeSinceSleep() -> void:
	elapsedTimeSinceSleep = timeOfLastSleep - Time.get_unix_time_from_system()

# Wird Jede Sekunde ausgelöst und führt alle Kalkulationen durch
func _on_timer_timeout() -> void:
	gesundheit = gesundheit - 1 #Testen der Function, sollte bei Ausführen der Szene den Gesundheitswert um 1 senken
