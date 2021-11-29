extends Area2D

# Declare member variables here.
var speed = 100.0
var maxSonarScale = 6.0
var isPinging = false
var pingSpeed = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# expand sonar circle if pinging
	if isPinging:
		self.get_node("SonarHitbox").scale.x += delta * pingSpeed
		self.get_node("SonarHitbox").scale.y += delta * pingSpeed
		if self.get_node("SonarHitbox").scale.x > maxSonarScale:
			resetSonar()
	# move towards mouse cursor
	if get_viewport().get_mouse_position().distance_to(self.position) > 0.5:
		var direction = self.position.direction_to(get_viewport().get_mouse_position())
		translate(direction * speed * delta)
		if direction.x * scale.x < 0:
			scale.x *= -1
			self.get_node("Vitals").scale.x *= -1

func resetSonar():
	isPinging = false
	self.get_node("SonarHitbox").scale.x = 0.0
	self.get_node("SonarHitbox").scale.y = 0.0

func startSonar():
	isPinging = true
	get_node("SonarSound").play()

func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
			if not isPinging and self.get_node("Vitals").health > 0:
				startSonar()
