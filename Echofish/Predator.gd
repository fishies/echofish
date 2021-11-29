extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Predator_area_entered(area):
	if area.name == "PlayerCharacter":
		#print("u ded")
		area.get_node("Vitals").health = 0.0
	# death animations? particools?
