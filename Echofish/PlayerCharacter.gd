extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = self.position.direction_to(get_viewport().get_mouse_position())
	translate(direction * speed)
	if direction.x * scale.x < 0:
		scale.x *= -1
