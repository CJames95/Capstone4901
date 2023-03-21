extends Node2D

var selected = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta):
	global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
