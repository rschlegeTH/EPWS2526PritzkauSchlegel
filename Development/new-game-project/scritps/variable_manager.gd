extends Node
#Hauptparameter
@export_range(0, 100) var gesundheit: float = 100 #Gesundheit Standard ist 100
@export_range(0, 100) var stress: float = 0#Stress Standard ist 0
@export_range(0, 100) var productivity: float = 100 #Produktivität Standard ist 100
@export_range(0, 100) var completion: float = 0 #Arbeitsfortschritt Standard ist 0

# Zeit für die Uhrzeit
@export_group("Zeit", "time")
@export_range(0,55, 5) var time_Minutes:int = 0
@export_range(0,23) var time_Hour:int = 0
# Deadline-Segment der Zeit
var dead: int = 1 # verbleibende Zeit zur deadline, zählt aufwärts, wichtig für calcStress, da höherer Wert = höherer Stresszuwachs
const DEADLINE: int = 6 # Wert, welchen dead erreichen muss, um die deadline auszulösen

# Zeit muss gezeitet werden

# Parameter zur Kalkulation der Zeit seit Schlaf
var timeOfLastSleep: float = Time.get_unix_time_from_system() # Standardwerte mit Unix_Time, sollte aber evtl mit engine Time gemacht werden?
var elapsedTimeSinceSleep: float # Standardwerte
#Sonstige Variablen
const SDIV: float = 100 #standerdDivider, wird für Beeinflussung der Rechnungeng verwendet und beeinflusst das Kurvenverhalten.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	calcElapsedTimeSinceSleep()

# Anpassen, weil g_mod < 1 und clamp immer auf 1 setzt
func calcGes() -> void:
	var g_mod = 0 # Gesundheits_Modifikitor, also der Wert, um den die Gesundheit verändert wird
	var erhöhung = 0.1 # Wachtum der Kurve
	if(timeOfLastSleep < 60):
		g_mod = tanh((stress)/SDIV)
	else:
		g_mod = tanh(stress)/SDIV + tanh((timeOfLastSleep-60)* erhöhung)
	g_mod = clampf(g_mod, 0, 1) #Ist 1 ein guter Wert für einen Clamp?
	gesundheit = gesundheit - g_mod
	
func calcStress() -> void:
	var s_mod:float # Stress_Modifikator, also der Wert, um den Stress verändert wird
	s_mod = (-gesundheit)/SDIV + ((-completion+100) * dead)/SDIV #deadline Wert(dead) beobachten
	s_mod = clampf(s_mod, -1, 1) # s_mod darf sich nur zwischen -1 bis 1 befinden und wird auf diese Limitiert
	stress = stress + s_mod # Werte anwenden

#Produktivitäsparameter berechnen
func calcProductitvity(): # Überarbeiten??? Berechnet die Produktivität, Formel könnte überarbeitet werden
	var localDivider = 2 # Wert um Stresswert auf die Hälfte zu limitieren
	productivity = clampf(gesundheit - stress / localDivider, 0, 100)

func addCompletion(completionGrowth = 1, minVal = 0, maxVal = 100) -> void:
	var prodPercent = productivity /100
	completion = clamp( completion + completionGrowth * prodPercent, minVal, maxVal)

func addGesundheit(Ges_Inc:int = 30):
	gesundheit = clampf(gesundheit+ Ges_Inc, 0, 100)

#Buttone
func workButton () -> void:
	print("work")
	addCompletion()
func sleepButton () -> void:
	print("sleep")
	sleep()
func gameButton () -> void:
	print("game")

# Berechnet den Zeitunterschied zwischen der aktuellen Zeit und timeOfLastSleep und weist diesen elapsedTimeSinceSleep zu.
func calcElapsedTimeSinceSleep() -> void:
	elapsedTimeSinceSleep = timeOfLastSleep - Time.get_unix_time_from_system()

# Setzt timeOfLastSleep auf die akutelle Zeit zurück
func resetSleepTimeVariables() -> void:
	timeOfLastSleep = Time.get_unix_time_from_system() #akutelle Zeit speichern
	calcElapsedTimeSinceSleep() # elapsedTimeSinceSleep rekalkulieren

# Schlafen, erhöht Gesundheitswert und verbraucht Zeit
func sleep(sleep_Increase: int=30, time_spent:int = 8):
	addGesundheit(sleep_Increase)
	increase_Time(time_spent)

# Uhrzeit erhöhen
func increase_Time(time_Inc:int = 0) -> void:
	if(time_Inc == 0):
		if(time_Minutes < 55):
			time_Minutes = time_Minutes + 5
		elif(time_Hour < 23):
			time_Minutes = 0
			time_Hour = time_Hour + 1
		else:
			time_Minutes = 0
			time_Hour = 0
			dead = dead + 1
	elif((time_Hour + time_Inc) < 23):
		time_Hour = time_Hour + time_Inc
	else:
		time_Hour = time_Hour + time_Inc - 24
		dead = dead + 1
	if(dead == DEADLINE):
		print("Deadline")

# Wird Jede Sekunde vom UpdateTimer-Signal ausgelöst und führt alle Kalkulationen durch
func _on_timer_timeout() -> void:
	calcGes()
	calcStress()
	calcProductitvity()
	calcElapsedTimeSinceSleep()
	increase_Time()
