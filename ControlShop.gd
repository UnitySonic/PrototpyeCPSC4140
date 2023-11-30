extends Control

var matches =  []
@onready var items = $ScrollContainer/items.get_children()
signal bananna
signal apple
signal trashBags


var removeMode = false

# Called when the node enters the scene tree for the first time.



func _on_searchbar_text_changed(new_text):
	new_text = new_text.to_lower()
	if new_text == "":
		for i in items:
			i.show()
		return
	matches.clear()
	for i in items:
		if new_text in i.text.to_lower():
			matches.append(i)
			
	for i in items:
		if i in matches:
			i.show()
		else:
			i.hide()


func _on_searchbar_mouse_entered():
	#get_node("ScrollContainer").visible = true
	pass


func _on_searchbar_mouse_exited():
	#get_node("ScrollContainer").visible = false
	pass


func _on_searchbar_gui_input(event):
	pass # Replace with function body.

func _input(event):
	var searchBar = get_node("Searchbar")
	var otherElement = get_node("ScrollContainer")
	# Check if the event is a mouse button press
	if event is InputEventMouseButton and event.pressed:
		# Check if the mouse click is within the bounds of the search bar
		if searchBar.get_rect().has_point(event.global_position):
			# Mouse click is within the search bar bounds, show the other element
			otherElement.visible = true
		elif event.global_position.x > 400:
			# Mouse click is outside the search bar bounds, hide the other element
			
			otherElement.visible = true
	


func _on_button_pressed():
	var button = $ScrollContainer/items/Button
	
	$ScrollContainer2/items/ZIPButton.visible = true
	
	$ScrollContainer/items/Button.visible = false
	$ScrollContainer/items/Button2.visible = false
	$ScrollContainer/items/Button3.visible = false
	
	
	
	bananna.emit(removeMode)
	
	


func _on_button_2_pressed():
	apple.emit(removeMode)
	var button = $ScrollContainer/items/Button2
	



func _on_button_3_pressed():
	trashBags.emit(removeMode)
	var button = $ScrollContainer/items/Button3
	var label = button.get_node("Label")
	


	


func _on_zip_button_pressed():
	get_tree().change_scene_to_file("res://node_2d.tscn")
	
