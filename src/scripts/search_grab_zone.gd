extends TextureRect

var searchbar = preload("res://src/scenes/searchbar_piece.tscn")
var root_scene
var searchbar_icon_node
var searchbar_instance
var made_instance = false
var area_entered = false

# Called when the node enters the scene tree for the first time.
# In this function root_scene is established as the node that contains the
# hint box and the browser, searchbar_instance creates and instance of the
# searchbar_piece scene, and searchbar_icon_node is established as the node
# that shows the little searchbar icon in this scene.
func _ready():
	root_scene = get_node("/root/Puzzle1/Workspace")
	searchbar_instance = searchbar.instantiate()
	searchbar_icon_node = get_node("Searchbar Icon")

# Called when something in the Area2D emits input of some type.
# If the input is a click and no searchbar has been made yet,
# then create a searchbar and place it in the root_scene node as a
# child. Then hide the Searchbar_Icon node. Otherwise if the click has been 
# released on the area, check to see if an object is in the area and a searchbar
# exists, then destroy the child and show the Searchbar_Icon node.
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if made_instance == false:
			made_instance = true
			root_scene.add_child(searchbar_instance)
			searchbar_icon_node.hide()
			searchbar_instance.position = get_global_mouse_position()
	if Input.is_action_just_released("click"):
		if made_instance == true and area_entered == true:
			made_instance = false
			root_scene.remove_child(searchbar_instance)
			searchbar_icon_node.show()
			searchbar_instance.delete_instance()
	if Input.is_action_just_pressed("R") or Input.is_action_pressed("R"):
		if made_instance == true:
			made_instance = false
			root_scene.remove_child(searchbar_instance)
			searchbar_icon_node.show()
			searchbar_instance.delete_instance()
# Called if an object enters the area of Area2D.
# If an object enters, switch area_entered to true.
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area_entered = true
	
# Called if an object leaves the area of Area2D.
# If an object leaves, switch area_entered to false.
func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	area_entered = false
