extends Area2D

# Declare member variables here.
var speed = 100.0
var maxHealth = 30.0
var health = maxHealth # time remaining to live
var survived = 0.0
var maxSonarScale = 10.0
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
			isPinging = false
			self.get_node("SonarHitbox").scale.x = 0.0
			self.get_node("SonarHitbox").scale.y = 0.0
	# tick down health by delta
	survived += delta
	health -= delta
	# check if player is still alive
	if health <= 0.0:
		# pop up a UI for play again? with your survived time
		survived = 0.0
		return
	# update health bar visual
	self.get_node("VitalsDisplay/HealthBar").value = health
	# move towards mouse cursor
	if get_viewport().get_mouse_position().distance_to(self.position) > 0.5:
		var direction = self.position.direction_to(get_viewport().get_mouse_position())
		translate(direction * speed * delta)
		if direction.x * scale.x < 0:
			scale.x *= -1

func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
			if not isPinging and health > 0:
				isPinging = true

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
