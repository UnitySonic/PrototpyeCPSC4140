extends Node2D

var astar = AStar2D.new();
var startNode = null
var endNode = null
var path



var groceryItems = {
	"bananna" : [0, 5],
	"apple" : [1,10],
	"broccoli" : [2,0],
	"grapes" : 3,
	"peppers": 4,	
	"tea" : 11,
	"cookies": 12,
	"soda" : 13,
	"chips": 14,
	"water" :15	,
	"proteinShake" : 16,
	"trashBags" : [23, 1],
	"plates" : 24,
	"vacuumCleaner": 25,
	"umbrella" : 26,
	"measuringTape": 27
	
	
}

var trackedList = {}
var currentTrackedItem = null


func addItem(item):
	
	if groceryItems[item][1] <= 0:
		$N_A.set_displayed_text("N/A")
		return
	trackedList[item] = 1
	print(startNode)
	calculateNextItem()
	

func removeItem(item):
	trackedList.erase(item)
	currentTrackedItem = null
	calculateNextItem()

func collectCurrentItem():
	
	groceryItems[currentTrackedItem][1] = groceryItems[currentTrackedItem][1] -1
	
	
	removeItem(currentTrackedItem)
	calculateNextItem()
	



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
	astar.connect_points(18, 19)
	astar.connect_points(19, 24)
	
	astar.connect_points(19,20)
	astar.connect_points(20,25)
	
	astar.connect_points(20,21)
	astar.connect_points(21,22)
	astar.connect_points(21, 26)
	astar.connect_points(21,16)
	
	
	
	astar.connect_points(17,22)
	
	
	astar.connect_points(19,12)
	astar.connect_points(19,24)
	astar.connect_points(20,14)
	astar.connect_points(20,25)
	astar.connect_points(21,16)
	astar.connect_points(21,26)
	
	astar.connect_points(18,23)
	astar.connect_points(22	,27)
	

	
	
	


# 2D Space
func distance_2d(point1: Vector2, point2: Vector2) -> float:
	return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
	


#Calculates Node Nearest to the Player and draws a line between them
func calculateNearestNode():
	var shortestDistance = 10000
	var pointIDToReturn = 1
	
	
	var listofPoints = astar.get_point_ids()
	
	for pointID in listofPoints:
		var currentNodePosition = astar.get_point_position(pointID)
		var distance = distance_2d(get_node("../Player").position, currentNodePosition)
		if distance < shortestDistance:
			shortestDistance = distance
			pointIDToReturn = pointID
	
	startNode = pointIDToReturn
	
	
	
	return pointIDToReturn


#This function sets up the endpoint


func compute_cost(start, end):
	var currentPath = astar.get_id_path(start, end)
	var totalCost = 0
	for point in currentPath:
		totalCost += astar.get_point_weight_scale(point)
	
	return totalCost  
	
	

func calculateNextItem():
	var costPointID =  [1000, 1000]
	currentTrackedItem = null
	endNode = null
	
	for item in trackedList:
		var groceryPointID = groceryItems[item][0]
		
		var cost = compute_cost(startNode, groceryPointID)
		if cost < costPointID[0]:
			costPointID = [cost, groceryPointID]
			currentTrackedItem = item
			endNode = costPointID[1]
	
	


func draw_path_lines():
	if startNode == null or endNode == null:
		return
	
	path = astar.get_point_path(startNode,endNode)
	if path.size() < 2:
		return  # Not enough points to draw a line

	for i in range(path.size() - 1):
		var start_point = path[i]
		var end_point = path[i+1]
		draw_line(start_point, end_point, Color(0, 0, 255), 1)  # Draw a green line between consecutive points
		
	

func drawPlayerToLine():
	if endNode == null:
		return
	var start_point = get_node("../Player").getPosition()
	var end_point = astar.get_point_position(calculateNearestNode())
	
	draw_line(start_point, end_point, Color(0,0,255), 1)

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
	drawPlayerToLine()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_process(true)
	print(startNode)
	calculateNearestNode()
	
	var displayText = "Currently Tracking: None"
	
	if currentTrackedItem != null:
		displayText = "Currently Tracking: " + currentTrackedItem
	$TextEdit.set_displayed_text(displayText)
	
	
	queue_redraw()
	





func _on_control_apple(removeMode):
	var item = "apple"
	if removeMode:
		removeItem(item)
	else:
		addItem(item)


func _on_control_bananna(removeMode):
	
	var item = "bananna"
	if removeMode:
		removeItem(item)
	else:
		addItem(item)


func _on_control_trash_bags(removeMode):
	var item = "trashBags"
	if removeMode:
		removeItem(item)
	else:
		addItem(item)


func _on_collect_item_pressed():
	collectCurrentItem()
