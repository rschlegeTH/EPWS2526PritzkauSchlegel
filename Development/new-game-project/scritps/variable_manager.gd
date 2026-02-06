@tool
extends Node
#Hauptparameter
@export_range(0, 100) var gesundheit: float = 100 ## Gesundheitsvariable. Standard ist 100.
@export_range(0, 100) var stress: float = 0 ## Stressvariable. Standard ist 0.
@export_range(0, 100) var productivity: float = 100 ## Produktivitätsvariable beschreibt die Produktivät bei Ausführen einer Aufgabe. Standard ist 100.
@export_range(0, 100) var completion: float = 0 ## Arbeitsfortschritt. Standard ist 0

#Kurven zur Parameter mod variabeln
@export var g_modTicksSinceSleep: Curve ## Kurve welche den Einfluss von ticksSinceSleep auf g_mod beschreibt
@export var g_modStress: Curve ## Kurve welche den Einfluss von stress auf g_mod beschreibt
@export var s_modDead: Curve ## Kurve welche den Einfluss von dead auf s_mod beschreibt
@export var s_modGesundheit: Curve ## Kurve welche den Einfluss von gesundheit auf s_mod beschreibt
@export var productivityTSS: Curve ## Kurve welche den Einfluss von der zeit seit dem aufstehen auf die produktivität beschreibt
@export var productivityScale: Curve ## Kurve welche den relativen Einfluss auf completion darstellt

# Zeit für die Uhrzeit
const  MINUTETICK: int = 5 ## Dauer eines GameTicks in Minuten, also "Wie viele Minuten soll ich diesen Tick den Timer erhöhen?"
@export_group("Zeit", "time")
@export var totalGameTicks: int = 0 ## Die Anzahl der gesammt verstrichenden Game Ticks
@export var time_Hour:int = 0 ## Der Stundenanteil der Uhrzeit.
@export var time_Minutes:int = 0 ## Der Minutenteil der Uhrzeit.
# Deadline-Segment der Zeit
var dead: int = 1 ## Verbleibende Zeit zur deadline, zählt aufwärts, wichtig für calcStress, da höherer Wert = höherer Stresszuwachs
const DEADLINE: int = 6 ## Wert, welchen dead erreichen muss, um die deadline auszulösen

# Zeit muss gezeitet werden
var debug_mode := false
# Parameter zur Kalkulation der Zeit seit Schlaf
@export_range(0, 288) var ticksSinceSleep: int = 0 ## Die vergangenen Ticks, seit der letzten Nutzung des Schlafbuttons.
#ALT Sonstige Variablen
var interactionObject: int = 0
# Anpassen, weil g_mod < 1 und clamp immer auf 1 setzt
## Führt die Kalkulation des Gesundheitswertes aus.
func calcGes() -> void:
	var g_mod: float = 0.0 ## Gesundheits_Modifikitor, also der Wert, um den die Gesundheit verändert wird
	var ticksSinceSleepPortion: float = 0.0 ## Der Anteil den ticksSinceSleep auf g_mod hat
	var stessPortion: float = 0.0 ## Der Anteil den stress auf g_mod hat
	
	ticksSinceSleepPortion = g_modTicksSinceSleep.sample(ticksSinceSleep/(48.0*60.0/MINUTETICK)) # Berechnet den Anteil von ticksSinceSleep auf g_mod. Begrenzt auf maximal 48 stunden
	stessPortion = g_modStress.sample(stress/100.0) # Berechnet den Anteil von stress auf g_mod
	
	g_mod = -(ticksSinceSleepPortion + stessPortion - 1) # Rechnung
	g_mod = clampf(g_mod, -1, 1) # Clampen
	gesundheit = clamp(gesundheit + g_mod, 0, 100)

## Führt die Kalkulation des Stresswertes aus
func calcStress() -> void:
	var s_mod:float ## Stress_Modifikator, also der Wert, um den Stress verändert wird
	var deadPortion: float = 0.0 ## Der Anteil den dead auf s_mod hat
	var gesundheitPortion: float = 0.0 ## Der Anteil den gesundheit auf s_mod hat
	
	deadPortion = s_modDead.sample((100.0-completion) * (dead-1) / 500.0) # Kurvenwert entnehmen
	gesundheitPortion = s_modGesundheit.sample(1.0-gesundheit/100.0) # Kurvenwert entnehmen
	
	s_mod = deadPortion + gesundheitPortion - 1
	#s_mod = (-gesundheit)/SDIV + ((-completion+100) * dead)/SDIV #deadline Wer   t(dead) beobachten (SDIV = 100)
	s_mod = clampf(s_mod, -1, 1) # s_mod darf sich nur zwischen -1 bis 1 befinden und wird auf diese Limitiert
	stress = clamp(stress + s_mod, 0, 100) # Werte anwenden

## Produktivitäsparameter berechnen
func calcProductitvity() -> void: # Überarbeiten??? Berechnet die Produktivität, Formel könnte überarbeitet werden
	var timeSinceSleepPortion: float = productivityTSS.sample(ticksSinceSleep/(48.0*60.0/MINUTETICK)) * 2
	productivity = clampf(gesundheit * 0.5 + (-stress + 100) * 0.5 * timeSinceSleepPortion, 0, 100)

## Erhöht den Completion-Wert um 1 oder den Eingabewert
func addCompletion(completionGrowth) -> void:
	if(completion == 100):
		print("Work Successfull!!!")
		return
	var prodPercent:float = productivityScale.sample(productivity * 0.01)  ## Productivity wird relativ zur ProductivityScale kurve multipliziert
	completion = completion + completionGrowth * prodPercent
	completion = clampf(completion, 0, 100)
	
## Gesundheit um den Eingabewert Erhöhen, Standartwert ist 30
func addGesundheit(Ges_Inc:float = 30) -> void:
	gesundheit = clampf(gesundheit + Ges_Inc, 0, 100)
	
## Stress um den Eingabewert Erhöhen, Standartwert ist 10
func addStress(Stress_Inc:float = 10) -> void:
	stress = clampf(stress + Stress_Inc, 0, 100)
	
## Buttone
func workButton () -> void:
	if(dead >= DEADLINE):
		return
	print("work")
	work()
func sleepButton () -> void:
	if(dead >= DEADLINE):
		return
	print("sleep")
	sleep()
func gameButton () -> void:
	if(dead >= DEADLINE):
		return
	print("game")
	playGame()

## Erhöht den Arbeitsfortschritt um die investierte Zeit und verbraucht die investierte Zeit.
func work(time_spent:int = 4, standardIncrease: float = 2) -> void: # standardIncrease beschreibt wie viel prozent Arbeit der Spieler pro Stunde schafft
	@warning_ignore("narrowing_conversion") addCompletion(time_spent * standardIncrease)
	@warning_ignore("integer_division") increase_Time(floor(time_spent * 60 / MINUTETICK))
	addStress(time_spent * standardIncrease)

## Schlafen, erhöht Gesundheitswert abhängig von der verbrauchten Zeit und verringert die Zeit um time_spent. standardIncrease beschreibt den Gesundheitsgewinn pro Stunde.
func sleep(time_spent:int = 8, standardIncrease: float = 10 ) -> void:
	if(ticksSinceSleep < 48):
		print("not tired yet")
		return
	@warning_ignore("integer_division") increase_Time(floor(time_spent * 60 / MINUTETICK))
	if(time_spent < 6):
		@warning_ignore("integer_division") ticksSinceSleep = (ticksSinceSleep/time_spent) 
	else:
		ticksSinceSleep = 0
		addGesundheit(time_spent * standardIncrease)
		addStress(-(time_spent))
	

## Wird bei drücken des "Play"-Buttons ausgeführt.
func playGame(time_spent: int=2, standardIncrease: float = 4 ) -> void:
	@warning_ignore("integer_division") increase_Time(floor(time_spent * 60 / MINUTETICK))
	addStress(-(time_spent * standardIncrease))

## Uhrzeit erhöhen um einen bestimmten Stundend-Wert, sollte keine Wert übergeben werden oder der Wert 0 sein, wird die Zeit um 5 min erhöht.
func increase_Time(time_Inc:int = 0) -> void:
	totalGameTicks = totalGameTicks + time_Inc
	var totalMinutes: int = totalGameTicks * MINUTETICK
	@warning_ignore("integer_division") var totalHours: int = floor(totalMinutes / 60) # 60 = dauer einer Stunde in Minuten
	@warning_ignore("integer_division") var totalDays: int = floor(totalHours / 24) # 24 = dauer eines Tages in Stunden
	time_Minutes = totalMinutes % 60
	time_Hour = totalHours % 24
	dead = clamp(1 + totalDays, 0, 6)
	for n in time_Inc: ## Ein Game tick pro Stunde der Aktivität ausführen
		calcGes()
		calcStress()
		calcProductitvity()
		ticksSinceSleep = ticksSinceSleep + 1
	print("Ges: " + str(gesundheit).pad_decimals(2) + "%" + " Stress: " + str(stress).pad_decimals(2) + "%")
	
## Wird zur berechnung des Spielendes benutzt, ob der Spieler gewonnen hat oder nicht
func calcEnding() -> int:
	if(dead < DEADLINE):
		return 0 ## Das Spiel ist noch nicht zuende
	if (completion < 100.0):
		return 1 ## Der Spieler hat es nicht geschafft die Aufgaben fertig zu stellen
	return 2 ## Der Spieler hat es geschafft die Aufgaben fertig zu stellen

## Wird Jede Sekunde vom UpdateTimer-Signal ausgelöst und führt alle Kalkulationen durch
func _on_timer_timeout() -> void:
	if(dead >= DEADLINE): #Deadline könnte um 23:55 getriggert werden, statt um 00:00
		print("Deadline")
		return
	if(!debug_mode):
		increase_Time(1)
	
func _input(event):
	if event.is_action_pressed("debug_pause"):
		debug_mode = !debug_mode
	if (event.is_action_pressed("interact") &&(interactionObject != 0)):
		if interactionObject == 1:
			sleepButton()
		elif  interactionObject == 2:
			gameButton()
		elif interactionObject == 3:
			workButton()
		
