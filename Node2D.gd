extends Node2D

export var astar = AStar2D.new()
var path
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Points on Left Wall
	astar.add_point(0, Vector2(200, 125), 4) # Adds the point (1, 0) with weight_scale 4 and id 1
	astar.add_point(1, Vector2(200, 225), 4)
	astar.add_point(2, Vector2(200, 325), 4)
	astar.add_point(3, Vector2(200, 425), 4)
	astar.add_point(4, Vector2(200, 525), 4)
	
	#Hallway
	astar.add_point(5, Vector2(400, 125), 4)
	astar.add_point(6, Vector2(400, 225), 4)
	astar.add_point(7, Vector2(400, 325), 4)
	astar.add_point(8, Vector2(400, 425), 4)
	astar.add_point(9, Vector2(400, 525), 4)
	
	#Points on LeftSide Center Shelf
	astar.add_point(11, Vector2(550, 225), 4)
	astar.add_point(13, Vector2(550, 325), 4)
	astar.add_point(15, Vector2(550, 425), 4)
	
	#Points on Right Side Center Shelf
	astar.add_point(12, Vector2(600, 225), 4)
	astar.add_point(14, Vector2(600, 325), 4)
	astar.add_point(16, Vector2(600, 425), 4)
	
	#HallWay Connectors LSide to Rside
	astar.add_point(10, Vector2(575, 125), 4)
	astar.add_point(17, Vector2(575, 525), 4)
	
	#Hallway Right Side
	
	astar.add_point(18, Vector2(750, 125), 4)
	astar.add_point(19, Vector2(750, 225), 4)
	astar.add_point(20, Vector2(750, 325), 4)
	astar.add_point(21, Vector2(750, 425), 4)
	astar.add_point(22, Vector2(750, 525), 4)
	
	
	
	
	
	
	#Right Side Wall
	astar.add_point(23, Vector2(950, 125), 4)
	astar.add_point(24 ,Vector2(950, 225), 4)
	astar.add_point(25 ,Vector2(950, 325), 4)
	astar.add_point(26 ,Vector2(950, 425), 4)
	astar.add_point(27, Vector2(950, 525), 4)
	path = astar.get_point_path(23,27)
	
	
	#Point Connections
	astar.connect_points(0,5)
	astar.connect_points(1,6)
	astar.connect_points(2,7)
	astar.connect_points(3,8)
	astar.connect_points(4,9)
	
	astar.connect_points(5,6)
	astar.connect_points(5,10)
	
	astar.connect_points(6,7)
	astar.connect_points(6,11)
	
	astar.connect_points(7,8)
	astar.connect_points(7,13)
	
	astar.connect_points(8,15)
	astar.connect_points(8,9)
	
	astar.connect_points(9,17)
	
	astar.connect_points(10,18)
	astar.connect_points(17,22)
	
	
	astar.connect_points(19,12)
	astar.connect_points(19,24)
	astar.connect_points(20,14)
	astar.connect_points(20,25)
	astar.connect_points(21,16)
	astar.connect_points(21,26)
	
	astar.connect_points(18,23)
	astar.connect_points(22	,27)
	
	path = astar.get_point_path(0,27)

	
func draw_path_lines():
	if path.size() < 2:
		return  # Not enough points to draw a line

	for i in range(path.size() - 1):
		var start_point = path[i]
		var end_point = path[i+1]
		draw_line(start_point, end_point, Color(0, 0, 255), 1)  # Draw a green line between consecutive points
	
	

func getAstar():
	return astar
	
func drawNodes():
	var list = [0, 1, 2, 3, 4, 11, 12, 13, 14, 15, 16, 23, 24, 25, 26, 27]

	# Draw nodes
	for i in range(28	):
		var Col1 = Color(255,0,0)
		var Col2 = Color (0,255,0)
		var colorToUse
		if list.has(i):
			colorToUse = Col1
		else:
			colorToUse = Col2
		var node_position = astar.get_point_position(i)
		draw_circle(node_position, 15, colorToUse)  # Draw a red circle at each node position
	

func _draw():
	# Clear previous drawings
	drawNodes()
	draw_path_lines()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_process(true)
	
