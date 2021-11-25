extends Node2D

var foodScene = load("res://Food.tscn")
var spawnChance = 0.6; # chance to spawn per "spawn tick" (timer node)
var maxSpawns = 3;
var maxXBound = 1024;
var maxYBound = 600;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SpawnTimer_timeout():
	if randf() < spawnChance:
		if get_tree().get_nodes_in_group("FoodList").size() < maxSpawns:
			var newFood = foodScene.instance()
			add_child(newFood)
			newFood.add_to_group("FoodList")
			newFood.set_position(Vector2(randi() % maxXBound, randi() % maxYBound))
