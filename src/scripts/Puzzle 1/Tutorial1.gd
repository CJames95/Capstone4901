extends Control

#Home Button
func _on_home_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/MainScreen.tscn")

#Skip Button
func _on_skip_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/Puzzle 1/Puzzle1.tscn")
