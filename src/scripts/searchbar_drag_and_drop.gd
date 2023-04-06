extends Node2D

var selected = false
var menu_selected = false
var search_text_checked = false
var created = true
var in_outer_box = false
var in_inner_box = false
var timer_start = false
var rest_point
var rest_nodes = []
var root_rest_node
var menu_node
var search_text

# Called when the node first enters the scene tree.
# This function creates a list of dock_zone nodes.
func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	menu_node = get_node("Search Menu")
	search_text = get_node("Search/Search Text")
		

# Called when the Search Bar is right clicked instead of left clicked.
# This function handles showing and hiding the context menu that starts
# as hidden in the node tree.
func show_menu():
	if menu_selected == false:
			menu_selected = true
			
			menu_node.position = get_local_mouse_position()
			menu_node.show()
	else:
		if menu_selected == true:
			menu_node.hide()
			menu_selected = false

# When input occurs in the Area2D node this function triggers.
# If the input is a left click, then switch selected to true.
# Alternatively, if the searchbar was just created, allow the
# user to drag the searchbar as long as the left click is still
# pressed.
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") or created == true and Input.is_action_pressed("click"):
		selected = true
		if menu_selected == true:
			menu_node.hide()
			menu_selected = false
	if Input.is_action_just_pressed("rclick"):
		show_menu()

# Called when the user interacts with the Search Bar while the 
# enable search text button in the context menu is toggled.
# This mirrors the function _on_area_2d_input_event() because
# the rich text label technically covers it and thus the user
# cannot left or right click to drag or show the context menu.
# By adding this, functionality remains unchanged when the 
# rich text label is enabled.
func _on_rich_text_label_gui_input(event):
	if Input.is_action_just_pressed("click") or created == true and Input.is_action_pressed("click"):
		selected = true
		if menu_selected == true:
			menu_node.hide()
			menu_selected = false
	if Input.is_action_just_pressed("rclick"):
		show_menu()

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

# Called when the check box button in the context menu
# is toggled by the user.
# This handles showing the rich text label Search Text
# by showing and hiding it as well as switching a variable
# to true or false to ensure the label is correctly shown.
func _on_search_text_checkbox_toggled(button_pressed):
	if search_text_checked == false:
		search_text_checked = true
		search_text.show()
	else:
		if search_text_checked == true:
			search_text_checked = false
			search_text.hide()

# Called when the user moves the mouse to the outer panel
# for the context menu. 
# When the user enters the outer panel, the timer is stopped
# and the timer is unable to start again because a variable is
# toggled to true.
func _on_search_menu_mouse_entered():
	if timer_start == true and menu_node.visible == true:
		timer_start = false
		$"Search Menu/Timer".stop()
	in_outer_box = true

# Called when the mouse leaves the context menu entirely.
# If the mouse has truly left the context menu and is not just
# hovering on the check box button instead, then the timer is started.
func _on_search_menu_mouse_exited():
	in_outer_box = false
	if in_inner_box == false and in_outer_box == false:
		timer_start = true
		$"Search Menu/Timer".start()

# Called when the user hovers over the check box button.
# This is here to make sure the user cannot accidentally lose
# the context menu because the mouse has left the outer panel.
# This ensures that the user must fully leave both the checkbox button
# and the outer panel to start the dissapear timer. 
func _on_search_text_checkbox_mouse_entered():
	in_inner_box = true

# Called when the user leaves the check box button.
# This just makes sure that the in_inner_box is toggled
# to false. Without it, the timer would never start.
func _on_search_text_checkbox_mouse_exited():
	in_inner_box = false

# Called when the timer countdown from 1 second expires.
# This function sets menu_selected to false so the user can
# immediately right click to have the context menu reappear.
# The menu_node for the context menu is then hidden.
# This makes sure that the context menu does not permenantly stay
# shown and block screen space.
func _on_timer_timeout():
	menu_selected = false
	menu_node.hide()
