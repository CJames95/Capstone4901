extends Container

var drop_zone = preload("res://src/scenes/dock_zone.tscn")
var drop_zone_instance
var x_size
var y_size

# Called when the node first enters the scene tree.
# This function creates a grid of dock_zone nodes
# 20 pixels apart across the entire container node.
func _ready():
	y_size = size.y / 20
	x_size = size.x / 20

	for i in y_size:
		for j in x_size:
			drop_zone_instance = drop_zone.instantiate()
			add_child(drop_zone_instance)
			drop_zone_instance.position = Vector2(j * 20 + 10, i * 20 + 10)

func getXSize():
	return x_size

func getYSize():
	return y_size