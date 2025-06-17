extends CanvasLayer

func _on_start_button_pressed():
	GlobalVars.score = 0
	if not GlobalVars.hi_score:
		GlobalVars.hi_score = 0
	get_tree().change_scene_to_file("res://Levels/world_3.tscn")

func _on_exit_button_pressed():
	get_tree().quit()


func _on_score_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/hall_of_fame.tscn")
