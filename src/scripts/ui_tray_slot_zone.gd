extends Marker2D

var searchbar = preload("res://src/puzzle_scene/searchbar_piece.tscn").instantiate()
var searchbar_pos = Vector2(0,0)

func _draw():
	draw_circle(Vector2.ZERO, 75, Color.BLANCHED_ALMOND)

func select():
	if Input.is_action_just_pressed("click"):
		print(searchbar)
		searchbar.set_pos(searchbar_pos)
		get_tree().add_child(searchbar)
