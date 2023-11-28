extends Node2D

var aStarGrids = load("res://Node2D.gd")
var moveSpeed = 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	




func _draw():
	# Set the drawing color to red
	draw_rect(Rect2(position.x, position.y, 25, 25), Color(1, 0, 0))
	
	#var closestNodeInfo =  calculateNearestNode()	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func getPosition():
	return position
func _process(delta):
	# Check arrow key input
	var direction := Vector2()

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
		

	# Normalize the direction to ensure consistent speed in all directions
	direction = direction.normalized()

	# Update the rectangle's position based on input and delta time
	
	position += direction * moveSpeed


func _on_searchbar_text_changed(new_text):
	pass # Replace with function body.
