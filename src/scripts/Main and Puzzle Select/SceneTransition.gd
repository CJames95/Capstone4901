extends CanvasLayer
"""
func change_scene(target: String, type: String = 'dissolve') -> void:
	if type == 'dissolve':
		transition_dissolve(target)
	else:
		transition_fish(target)

func transition_dissolve(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	await($AnimationPlayer,'animation_finished')
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
"""
"""
signal transitioned

func _ready():
	transition()

func transition():
	$AnimationPlayer.play("dissolve")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "dissolve":
		emit_signal("transitioned")
		$AnimationPlayer.play("RESET")
"""
