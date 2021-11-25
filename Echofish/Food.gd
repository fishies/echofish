extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Food_area_entered(area):
	if area.name == "PlayerCharacter":
		if area.health > 0.0:
			print("u eat")
			area.health += 2.0
			queue_free()
