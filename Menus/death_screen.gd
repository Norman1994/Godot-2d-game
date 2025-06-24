extends Node2D

var played_death_sound = false

func _ready():
	visible = false

func _process(delta: float) -> void:
	if visible and not played_death_sound:
		get_tree().paused = true
		death_sound()
		played_death_sound = true
	elif not visible:
		get_tree().paused = false
		played_death_sound = false

func _on_resume_pressed() -> void:
	get_tree().paused = false
	GlobalVars.score = 0
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	
func death_sound():
		$DeathScream.play()
