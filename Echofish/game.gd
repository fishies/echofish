extends Node2D

var foodScene = load("res://Food.tscn")
var anglerScene = load("res://Predator.tscn")
var spawnChance = 0.6; # chance to spawn per "spawn tick" (timer node)
var maxSpawns = 9;
const maxXBound = 1024;
const maxYBound = 600;

var random = RandomNumberGenerator.new()

#var formatString = "[center][b]Time Survived:[/b]\n %.3f seconds[/center]"

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	endGame()

func startGame():
	while get_tree().get_nodes_in_group("FoodList").size() < maxSpawns:
		spawnFood()
	get_tree().paused = false
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_node("PlayerCharacter/Vitals").resetState()
	get_node("PlayerCharacter").resetSonar()
	get_node("PlayerCharacter").startSonar()
	get_node("PlayerCharacter/FixedDisplay/PlayPrompt").visible = false
	get_node("PlayerCharacter").position = Vector2(160.0,128.0)
	get_node("Predator").position = Vector2(512.0,320.0)
	get_node("Predator/Light2D").energy = 0.0
	for angler in get_tree().get_nodes_in_group("NewAnglers"):
		angler.queue_free()
	get_node("AnglerEnrage").start()
	
func endGame():
	get_tree().paused = true
	get_node("PlayerCharacter/FixedDisplay/PlayPrompt").visible = true
	get_node("Predator/Light2D").energy = 16.0
	for fish in get_tree().get_nodes_in_group("FoodList"):
		fish.get_node("Light2D").energy = 16.0
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnFood():
	var newFood = foodScene.instance()
	add_child(newFood)
	newFood.add_to_group("FoodList")
	newFood.set_position(Vector2(random.randi() % maxXBound, random.randi() % maxYBound))

func _input(event):
	#restart game upon receiving input
	if get_tree().paused:
		if event is InputEventKey or event is InputEventMouseButton:
			if event.is_pressed() and not event.is_echo():
				startGame()

func _on_SpawnTimer_timeout():
	if random.randf() < spawnChance:
		if get_tree().get_nodes_in_group("FoodList").size() < maxSpawns:
			spawnFood()

func _on_AnglerEnrage_timeout():
	var newAngler = anglerScene.instance()
	add_child(newAngler)
	newAngler.add_to_group("NewAnglers")
	newAngler.set_position(get_node("Predator").position)
	newAngler.scale.x = get_node("Predator").scale.x
	newAngler.get_node("Light2D").energy = 8.0
