extends CanvasLayer

var dialogue = []
var currentDialogue = 0

var file = "res://src/art/Main and Puzzle Select/Dialogue/Puzzle2_Tutorial.json"
var jsonText = FileAccess.get_file_as_string(file)
var jsonDictionary = JSON.parse_string(jsonText)

func _ready():
	start()
	$NinePatchRect/Chat2.text = dialogue[0]['text']

func start():
	dialogue = jsonDictionary

func _on_next_btn_pressed() -> void:
	next_script()
	if currentDialogue >= len(dialogue):
		get_tree().change_scene_to_file("res://src/scenes/Puzzle 2/Puzzle2.tscn")

func next_script():
	currentDialogue += 1
	
	if currentDialogue >= len(dialogue):
		return
		
	$NinePatchRect/Chat2.text = dialogue[currentDialogue]['text']
