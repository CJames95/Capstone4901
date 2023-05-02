extends Container

var drop_zone = preload("res://src/scenes/dock_zone.tscn")
var drop_zone_instance

# Called when the node first enters the scene tree.
# This function creates a grid of dock_zone nodes
# 20 pixels apart across the entire container node.
func _ready():
	for i in size.y / 20:
		print(i)
		for j in size.x / 20:
			drop_zone_instance = drop_zone.instantiate()
			add_child(drop_zone_instance)
			drop_zone_instance.position = Vector2(j * 20 + 10, i * 20 + 10)
			print(j)
