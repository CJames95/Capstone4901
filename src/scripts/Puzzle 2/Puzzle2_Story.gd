extends Control

#Scene Transition
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$SceneTransition.transition()

#Home Button
func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/MainScreen.tscn")

func _on_skip_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/Puzzle 2/Tutorial2.tscn")
