extends BoxContainer

var escape_menu
var escape_menu_showing = false

func _ready():
	escape_menu = get_node(".")

func _on_exit_btn_pressed():
	escape_menu.show()
	escape_menu_showing == true

func _on_button_pressed():
	get_tree().quit()

func _on_keep_playing_btn_pressed():
	escape_menu.hide()
	escape_menu_showing == false
