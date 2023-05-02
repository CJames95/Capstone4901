extends Control

func _on_retry_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/Puzzle 1/Puzzle1.tscn")

func _on_exit_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/PuzzleSelectPage.tscn")

func _on_next_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/PuzzleSelectPage.tscn")
	#get_tree().change_scene_to_file(puzzle2)
