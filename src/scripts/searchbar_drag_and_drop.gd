extends Node2D

var selected = false
var created = true
var rest_point
var rest_nodes = []
var root_rest_node

# Called when the node first enters the scene tree.
# This function creates a list of dock_zone nodes.
func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")

# When input occurs in the Area2D node this function triggers.
# If the input is a left click, then switch selected to true.
# Alternatively, if the searchbar was just created, allow the
# user to drag the searchbar as long as the left click is still
# pressed.
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") or created == true and Input.is_action_pressed("click"):
		selected = true
 

# This function handles the physics of moving the searchbar.
# If selected is true, then change the searchbar's position at a speed of
# 25 * delta from its current position to the mouse position.
# Alternatively, if selected is not true, then check if the searchbar has a 
# dock_zone node it has been docked to. If true, move the searchbar at the speed of
# 10 * delta from current position to the rest_point position.
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		if rest_point != null:
			global_position = lerp(global_position, rest_point, 10 * delta)

# This function occurs when there is input on the searchbar.
# If left click was pressed and is no longer pressed, then
# set selected and created to false. If a dock_zone is a distance of
# less than 15 pixels, move to that dock_zone node and then trigger
# the dock_zone in the center as well as all dock zones 8 minus and plus
# the center node in rest_nodes. They all turn maroon and prevent other objects
# from docking there.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			created = false
			var shortest_dist = 15
			for i in len(rest_nodes):
				var distance = global_position.distance_to(rest_nodes[i].global_position)
				if distance < shortest_dist and i % 81 > 7 and i % 81 < 73 and rest_nodes[i].return_modulate() != Color.WEB_MAROON:
					var node_test = false
					for x in 9:
						if x == 0:
							x = x + 1
						if(rest_nodes[i+x].return_modulate() == Color.WEB_MAROON
						or rest_nodes[i-x].return_modulate() == Color.WEB_MAROON):
							node_test = true
							break
					if node_test == false:
						if root_rest_node != null:
							rest_nodes[root_rest_node].deselect()
							for j in 9:
								if j == 0:
									j = j + 1
								rest_nodes[root_rest_node-j].deselect()
							for j in 9:
								if j == 0:
									j = j + 1
								rest_nodes[root_rest_node+j].deselect()
						root_rest_node = i
						rest_nodes[i].select()
						for j in 9:
							if j == 0:
								j = j + 1
							rest_nodes[i-j].select()
						for j in 9:
							if j == 0:
								j = j + 1
							rest_nodes[i+j].select()
						rest_point = rest_nodes[i].global_position
						shortest_dist = distance
						break

# This function has to be manually called.
# This function should only ever be called by the node script
# which created the instance of the searchbar. Set created to true
# and deselect all rest_nodes. Then set rest_point and root_rest_node
# to null to avoid the searchbar being recreated at some random location.
func delete_instance():
	created = true
	if root_rest_node != null and rest_point != null:
		rest_nodes[root_rest_node].deselect()
		for j in 9:
			if j == 0:
				j = j + 1
			rest_nodes[root_rest_node-j].deselect()
		for j in 9:
			if j == 0:
				j = j + 1
			rest_nodes[root_rest_node+j].deselect()
	rest_point = null
	root_rest_node = null
