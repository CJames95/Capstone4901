extends Control

#Home Button
func _on_home_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/MainScreen.tscn")

func _on_confirm_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/pass_puzzle.tscn")

func _on_info_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/Puzzle 1/Tutorial1.tscn")
