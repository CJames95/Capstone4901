extends TextureRect

var logo = preload("res://src/scenes/logo_piece.tscn")
var root_scene
var logo_icon_node
var logo_instance
var made_instance = false
var area_entered = false

# Called when the node enters the scene tree for the first time.
# In this function root_scene is established as the node that contains the
# hint box and the browser, logo_instance creates and instance of the
# logo_piece scene, and logo_icon_node is established as the node
# that shows the little logo icon in this scene.
func _ready():
	root_scene = get_node("/root/Puzzle1/Workspace")
	logo_instance = logo.instantiate()
	logo_icon_node = get_node("Small Logo")

# Called when something in the Area2D emits input of some type.
# If the input is a click and no logo has been made yet,
# then create a logo and place it in the root_scene node as a
# child. Then hide the Small Logo node. Otherwise if the click has been 
# released on the area, check to see if an object is in the area and a logo
# exists, then destroy the child and show the Small Logo node.
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if made_instance == false:
			made_instance = true
			root_scene.add_child(logo_instance)
			logo_icon_node.hide()
			logo_instance.position = get_global_mouse_position()
	if Input.is_action_just_released("click"):
		if made_instance == true and area_entered == true:
			made_instance = false
			root_scene.remove_child(logo_instance)
			logo_icon_node.show()
			logo_instance.delete_instance()

# Called if an object enters the area of Area2D.
# If an object enters, switch area_entered to true.
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area_entered = true
	
# Called if an object leaves the area of Area2D.
# If an object leaves, switch area_entered to false.
func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	area_entered = false
