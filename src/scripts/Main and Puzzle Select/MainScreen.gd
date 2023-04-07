extends Control

func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/PuzzleSelectPage.tscn")
