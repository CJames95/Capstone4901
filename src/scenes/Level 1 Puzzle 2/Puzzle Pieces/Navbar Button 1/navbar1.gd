extends Node2D

var selected = false
var created = true
var grid_y
var grid_x
var search_size_y
var search_size_x
var temp_rest_nodes = []
var rest_point
var rest_nodes = []
var root_rest_node_y
var root_rest_node_x
var grid_container

# Called when the node first enters the scene tree.
# This function creates a list of dock_zone nodes.
func _ready():
	grid_container = get_node("/root/Puzzle1/WebTemplate/Container")
	
	temp_rest_nodes = get_tree().get_nodes_in_group("zone")
	grid_y = grid_container.getYSize()
	grid_x = grid_container.getXSize()
	search_size_y = (60 / 40) + 0.5
	search_size_x = (60 / 40) + 0.5

	var init = 0
	for y in range(grid_y):
		rest_nodes.append([])
		for x in range(grid_x):
			rest_nodes[y].append(temp_rest_nodes[init])
			init = init + 1

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
			for y in grid_y:
				for x in grid_x:
					var distance = global_position.distance_to(rest_nodes[y][x].global_position)
					if distance < shortest_dist and rest_nodes[y][x].return_modulate() != Color.WEB_MAROON:
						var node_test = false
						for i in search_size_y:
							for j in search_size_x:
								if(rest_nodes[y + i][x + j].return_modulate() == Color.WEB_MAROON
								or rest_nodes[y + i][x - j].return_modulate() == Color.WEB_MAROON
								or rest_nodes[y - i][x + j].return_modulate() == Color.WEB_MAROON
								or rest_nodes[y - i][x - j].return_modulate() == Color.WEB_MAROON):
									node_test = true
									break
						if node_test == false:
							if root_rest_node_y != null and root_rest_node_x != null:
								rest_nodes[root_rest_node_y][root_rest_node_x].deselect()
								for i in search_size_y:
									for j in search_size_x:
										rest_nodes[root_rest_node_y - i][root_rest_node_x - j].deselect()
										rest_nodes[root_rest_node_y - i][root_rest_node_x + j].deselect()
										rest_nodes[root_rest_node_y + i][root_rest_node_x - j].deselect()
										rest_nodes[root_rest_node_y + i][root_rest_node_x + j].deselect()
							root_rest_node_y = y
							root_rest_node_x = x
							rest_nodes[y][x].select()
							for i in search_size_y:
								for j in search_size_x:
									rest_nodes[y - i][x - j].select()
									rest_nodes[y - i][x + j].select()
									rest_nodes[y + i][x - j].select()
									rest_nodes[y + i][x + j].select()
							rest_point = rest_nodes[y][x].global_position
							shortest_dist = distance
							print('break')
							break
			

# This function has to be manually called.
# This function should only ever be called by the node script
# which created the instance of the searchbar. Set created to true
# and deselect all rest_nodes. Then set rest_point and root_rest_node
# to null to avoid the searchbar being recreated at some random location.
func delete_instance():
	created = true
	if root_rest_node_y != null and root_rest_node_x != null and rest_point != null:
		rest_nodes[root_rest_node_y][root_rest_node_x].deselect()
		for i in search_size_y:
			for j in search_size_x:
				rest_nodes[root_rest_node_y - i][root_rest_node_x - j].deselect()
				rest_nodes[root_rest_node_y - i][root_rest_node_x + j].deselect()
				rest_nodes[root_rest_node_y + i][root_rest_node_x - j].deselect()
				rest_nodes[root_rest_node_y + i][root_rest_node_x + j].deselect()
	rest_point = null
	root_rest_node_y = null
	root_rest_node_x = null
