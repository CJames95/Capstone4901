extends Marker2D

var ui_piece_type = 0

# Draws 1 pixel circles that are blanched almond in color
# where the node's position is. 
func _draw():
	draw_circle(Vector2.ZERO, 1, Color.LIGHT_SKY_BLUE)

# Change the color to web maroon.
func select():
	modulate = Color.WEB_MAROON
	ui_piece_type = 1

# Change the color to white.
func deselect():
	modulate = Color.WHITE
	ui_piece_type = 0

# Return the color that the node is.
func return_modulate():
	return modulate
