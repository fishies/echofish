extends Area2D

# Declare member variables here.
var speed = 100.0
var maxHealth = 30.0
var health = maxHealth # time remaining to live
var survived = 0.0
var maxSonarScale = 10.0
var isPinging = false
var pingSpeed = 1.0

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
	health -= delta
	# cap player's health at max
	if health > maxHealth:
		health = maxHealth
	# check if player is still alive
	if health <= 0.0:
		# pop up a UI for play again? with your survived time
		#survived = 0.0
		return
	survived += delta
	# update health bar visual
	self.get_node("VitalsDisplay/HealthBar").value = health
	# update cooldown orb visual
	self.get_node("VitalsDisplay/CooldownOrb").value = self.get_node("VitalsDisplay/CooldownOrb").max_value - ((self.get_node("SonarHitbox").scale.x / maxSonarScale) * self.get_node("VitalsDisplay/CooldownOrb").max_value)
	# move towards mouse cursor
	if get_viewport().get_mouse_position().distance_to(self.position) > 0.5:
		var direction = self.position.direction_to(get_viewport().get_mouse_position())
		translate(direction * speed * delta)
		if direction.x * scale.x < 0:
			scale.x *= -1
			self.get_node("VitalsDisplay").scale.x *= -1

func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
			if not isPinging and health > 0:
				isPinging = true
