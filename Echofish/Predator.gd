extends Area2D

var glowDecayRate = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("Light2D").energy > 0.0:
		get_node("Light2D").energy -= delta * glowDecayRate

func _on_Predator_area_entered(area):
	if area.name == "PlayerCharacter":
		#print("u ded")
		area.get_node("Vitals").health = 0.0
		# death animations? particools?
	if area.name == "SonarHitbox":
		get_node("Light2D").energy = 16.0
