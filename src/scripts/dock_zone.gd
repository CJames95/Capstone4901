extends Marker2D

# Draws 1 pixel circles that are blanched almond in color
# where the node's position is. 
func _draw():
	draw_circle(Vector2.ZERO, 1, Color.BLANCHED_ALMOND)

# Change the color to web maroon.
func select():
	modulate = Color.WEB_MAROON

# Change the color to white.
func deselect():
	modulate = Color.WHITE

# Return the color that the node is.
func return_modulate():
	return modulate
