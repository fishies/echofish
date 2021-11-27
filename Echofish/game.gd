extends Node2D

var foodScene = load("res://Food.tscn")
var spawnChance = 0.6; # chance to spawn per "spawn tick" (timer node)
var maxSpawns = 3;
const maxXBound = 1024;
const maxYBound = 600;

var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	#get_tree().paused = true

func startGame():
	while get_tree().get_nodes_in_group("FoodList").size() < maxSpawns:
		spawnFood()
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnFood():
	var newFood = foodScene.instance()
	add_child(newFood)
	newFood.add_to_group("FoodList")
	newFood.set_position(Vector2(random.randi() % maxXBound, random.randi() % maxYBound))

func _on_SpawnTimer_timeout():
	if random.randf() < spawnChance:
		if get_tree().get_nodes_in_group("FoodList").size() < maxSpawns:
			spawnFood()
