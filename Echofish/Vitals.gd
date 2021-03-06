extends Node2D

var maxHealth = 30.0
var health = maxHealth # time remaining to live
var survived = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func resetState():
	health = maxHealth
	survived = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# tick down health by delta
	health -= delta
	# cap player's health at max
	if health > maxHealth:
		health = maxHealth
	# check if player is still alive
	if health <= 0.0:
		get_parent().get_parent().endGame()
		return
	survived += delta
	# update health bar visual
	self.get_node("HealthBar").value = health
	# update cooldown orb visual
	if get_parent().isPinging:
		self.get_node("CooldownOrb").value = ((get_parent().get_node("SonarHitbox").scale.x / get_parent().maxSonarScale) * self.get_node("CooldownOrb").max_value)
	else:
		self.get_node("CooldownOrb").value = self.get_node("CooldownOrb").max_value
