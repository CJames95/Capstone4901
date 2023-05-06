extends Node

var has_searchbar = 0
var visiblity_of_system_stat = 0
var has_account = 0
var has_help = 0
var help_and_doc = 0

# Called when the X button is pressed by the user.
# Performs a series of checks to determine if the user fulfilled
# their tasks for this puzzle. It then shows a confirmation window
# so that the user can confirm that they want to finish.
func _on_confirm_btn_pressed():
	if $Workspace.has_node("Search Bar Piece"):
		if has_searchbar < 1:
			has_searchbar = has_searchbar + 1
		if $"Workspace/Search Bar Piece".search_text_checked == true:
			if visiblity_of_system_stat < 1:
				visiblity_of_system_stat = visiblity_of_system_stat + 1
		else:
			if visiblity_of_system_stat > 0:
				visiblity_of_system_stat = visiblity_of_system_stat - 1
	else:
		if has_searchbar > 0:
			has_searchbar = has_searchbar - 1
	if $Workspace.has_node("Account Piece"):
		if has_account < 1:
			has_account = has_account + 1
	else:
		if has_account > 0:
			has_account = has_account - 1
	if $Workspace.has_node("Help Piece"):
		if has_help < 1:
			has_help = has_help + 1
		if help_and_doc < 1:
			help_and_doc = help_and_doc + 1
	else:
		if has_help > 0:
			has_help = has_help - 1
		if help_and_doc > 0:
			help_and_doc = help_and_doc - 1
	$"End Puzzle Confirmation".show()

# Called when the user selects the yes button on the confirmation
# window. 
# If they select yes, their score is printed and the confirmation
# menu is hidden.
func _on_yes_button_down():
	print("Basic Requirements: ", has_searchbar + has_account + has_help, "/3")
	print("Visibility of System Status: ", visiblity_of_system_stat, "/1")
	print("Help and Documentation: ", help_and_doc, "/1")
	$"End Puzzle Confirmation".hide()
	if ((has_searchbar + has_account + has_help) >= 2) :
		get_tree().change_scene_to_file("res://src/scenes/pass_puzzle.tscn") 
	else :
		get_tree().change_scene_to_file("res://src/scenes/fail_puzzle.tscn")
	#get_tree().quit()

# Called when the user selects the no button on the confirmation
# window.
# If they select no, the confirmation window is hidden.
func _on_no_button_down():
	$"End Puzzle Confirmation".hide()
	
#Home Button
func _on_home_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/MainScreen.tscn")
	
func _on_info_btn_pressed():
	get_tree().change_scene_to_file("res://src/scenes/Puzzle 2/Tutorial2.tscn")

