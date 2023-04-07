extends CanvasLayer

signal transitioned

func _ready():
	transition()

func transition():
	$AnimationPlayer.play("dissolve")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "dissolve":
		emit_signal("transitioned")
		$AnimationPlayer.play("RESET")
