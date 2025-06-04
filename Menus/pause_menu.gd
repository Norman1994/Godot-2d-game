extends Control

func _ready():
	visible = false

func resume():
	get_tree().paused = false
	visible = false
	
func pause():
	get_tree().paused = true
	visible = true
	
func testEsc():
	if Input.is_action_just_pressed("exit") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("exit") and get_tree().paused == true:
		resume()

func _on_resume_pressed():
	resume()

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	
func _process(delta):
	testEsc()
