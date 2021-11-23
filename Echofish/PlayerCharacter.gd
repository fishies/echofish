extends Area2D

# Declare member variables here.
var speed = 100.0
var health = 30.0 # time remaining to live
var survived = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# tick down health by delta
	survived += delta
	health -= delta
	# check if player is still alive
	if health <= 0.0:
		# pop up a UI for play again? with your survived time
		survived = 0.0
		return
	# move towards mouse cursor
	var direction = self.position.direction_to(get_viewport().get_mouse_position())
	translate(direction * speed * delta)
	if direction.x * scale.x < 0:
		scale.x *= -1

func _on_Predator_area_entered(area):
	#implement death here
	if area == self:
		print("u ded")
		health = 0.0
	# death animations? particools?

func _on_Food_area_entered(area):
	#food eating behavior
	if area == self:
		print("u eat")
		health += 2.0
