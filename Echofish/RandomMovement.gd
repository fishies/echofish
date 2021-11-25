extends Node2D

var speed = 50.0
var distToMove = 0.0
var dirToMove = Vector2(1.0, 0.0)

var game = load("res://game.gd")
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# process move
	get_parent().translate(dirToMove * speed * delta)
	distToMove -= speed * delta
	# check if out of bounds
	if get_parent().position.x >= game.maxXBound:
		distToMove = 0.0
		get_parent().position.x = game.maxXBound-1
	if get_parent().position.x < 0:
		distToMove = 0.0
		get_parent().position.x = 0
	if get_parent().position.y >= game.maxYBound:
		distToMove = 0.0
		get_parent().position.y = game.maxYBound-1
	if get_parent().position.y < 0:
		distToMove = 0.0
		get_parent().position.y = 0
	# change direction if done moving in current direction
	if distToMove <= 0.0: # change direction
		distToMove = random.randfn(200.0, 50.0)
		dirToMove = Vector2(random.randf()-0.5, random.randf()-0.5).normalized()
		
