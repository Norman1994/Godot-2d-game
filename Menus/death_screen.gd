extends Node2D

var played_death_sound = false

func _ready():
	visible = false

func _process(delta: float) -> void:
	if visible and not played_death_sound:
		death_sound()
		played_death_sound = true
	elif not visible:
		played_death_sound = false

func _on_resume_pressed() -> void:
	GlobalVars.score = 0
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	
func death_sound():
		$DeathScream.play()
