extends TextureRect

var ad_section = preload("res://src/scenes/ad_section_piece.tscn")
var root_scene
var ad_section_icon_node
var ad_section_instance
var made_instance = false
var area_entered = false

# Called when the node enters the scene tree for the first time.
# In this function root_scene is established as the node that contains the
# hint box and the browser, logo_instance creates and instance of the
# logo_piece scene, and logo_icon_node is established as the node
# that shows the little logo icon in this scene.
func _ready():
	root_scene = get_node("/root/Puzzle2/Workspace")
	ad_section_instance = ad_section.instantiate()
	ad_section_icon_node = get_node("Small Ad section")

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
			root_scene.add_child(ad_section_instance)
			ad_section_icon_node.hide()
			ad_section_instance.position = get_global_mouse_position()
	if Input.is_action_just_released("click"):
		if made_instance == true and area_entered == true:
			made_instance = false
			root_scene.remove_child(ad_section_instance)
			ad_section_icon_node.show()
			ad_section_instance.delete_instance()

# Called if an object enters the area of Area2D.
# If an object enters, switch area_entered to true.
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area_entered = true
	
# Called if an object leaves the area of Area2D.
# If an object leaves, switch area_entered to false.
func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	area_entered = false
