extends Node2D

var aStarGrids = load("res://Node2D.gd")
var moveSpeed = 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _draw():
	# Set the drawing color to red
	draw_rect(Rect2(50, 50, 25, 25), Color(1, 0, 0))
	
	closestNodeInfo =  calculateNearestNode()

# 2D Space
func distance_2d(point1: Vector2, point2: Vector2) -> float:
	return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))



func calculateNearestNode():
	var shortestDistance = 1
	var shortestNodePosition = null
	
	
	var listofPoints = aStarGrids.aStar.get_point_ids()
	
	for pointID in listofPoints:
		var currentNodePosition = aStarGrids.aStar.get_point_position(pointID)
		var distance = distance_2d(position, currentNodePosition)
		if distance < shortestDistance:
			shortestDistance = distance
			shortestNodePosition = currentNodePosition
	
	return [shortestDistance, shortestNodePosition]
		
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
