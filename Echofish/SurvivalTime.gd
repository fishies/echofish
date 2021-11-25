extends RichTextLabel

var formatString = "[center][b]Time Survived:[/b]\n %.3f seconds[/center]"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bbcode_text = formatString % get_parent().get_parent().survived
