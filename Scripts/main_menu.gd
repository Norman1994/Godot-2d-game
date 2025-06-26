extends CanvasLayer

var save_path = "res://SaveData/savegame.cfg"

func _ready() -> void:
	if !FileAccess.file_exists(save_path):
		$MarginContainer/VBoxContainer/Continue.disabled = true

func _on_start_button_pressed():
	GlobalVars.score = 0
	if not GlobalVars.hi_score:
		GlobalVars.hi_score = 0
	get_tree().change_scene_to_file("res://Levels/world.tscn")

func _on_exit_button_pressed():
	get_tree().quit()


func _on_score_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/hall_of_fame.tscn")

func _on_continue_pressed() -> void:
	SaveSystem.load_game() # Replace with function body.
