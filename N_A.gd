extends TextEdit

var timeMessageShown = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if text != "":
		visible = true
		timeMessageShown += 1
	
	if timeMessageShown > 300:
		visible = false
		timeMessageShown = 0
		text = ""
func set_displayed_text(new_text: String) -> void:
	# Set the text of the TextEdit control
	text = new_text
