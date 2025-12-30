extends Node
var gesundheit: float = 100 #Gesundheit

var stress: float = 0

var productivity: float = 100 #Produktivität

var completion: int = 0 #Arbeitsfortschritt
var dead: int = 1 #verbleibende Zeit zur deadline
var deadline: int = 6
var deadMult: float = 0.5
# Zeit muss gezeitet werden
var zeit: int # muss verbessert werden
var timeLastSleep: int = 0

var sDiv: int = 100 #standerdDivider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass

func calcGes():
	var g_mod = 0
	var erhöhung = 0.1
	if(timeLastSleep < 60):
		g_mod = tanh((stress)/sDiv)
	else:
		g_mod = tanh(stress)/sDiv + tanh((timeLastSleep-60)* erhöhung)
	g_mod = clampf(g_mod, 0, 1) #Ist 1 ein guter Wert für einen Clamp?
	gesundheit = gesundheit - g_mod
	
func calcStress():
	var s_mod = (-gesundheit)/sDiv + ((-completion+100) * dead)/sDiv #deadline Wert(dead) beobachten
	s_mod = clampf(s_mod, -1, 1)
	stress = stress + s_mod

func addCompletion():
	var minVal = 0
	var maxVal = 100
	var completionGrowth = 1
	completion = clamp( completionGrowth, minVal, maxVal)

func calcProductitvity(stress: float, gesund: float) -> float: # Überarbeiten???
	var productiv = clampf(gesund - stress*0.5, 0, 100)
	return productiv
