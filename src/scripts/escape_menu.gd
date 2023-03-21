extends SubViewportContainer

var escape_menu
var escape_menu_showing = false

# Called when the node enters the scene tree for the first time.
# This function establishes escape_menu as the Escape Menu node
# to show and hide it later.
func _ready():
	escape_menu = get_node(".")

# Called when input occurs. 
# If input is escape key show the escape menu if it is hidden
# and hide it if it is shown.
func _input(event):
	if Input.is_action_just_pressed("escape"):
		if escape_menu_showing == true:
			escape_menu.hide()
			escape_menu_showing = false
		else:
			escape_menu.show()
			escape_menu_showing = true

# Quits the game when pressed down.
func _on_exit_game_button_button_down():
	get_tree().quit()
