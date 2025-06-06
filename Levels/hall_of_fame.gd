extends CanvasLayer

func _ready() -> void:
	$MarginContainer/VBoxContainer/HiScore.text = "Лучший рекорд: " + str(GlobalVars.score)

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
