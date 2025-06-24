extends Control

func _ready():
	visible = false
	
func resume():
	get_tree().paused = false
	print_debug("А вот здесь ", get_tree().paused)
	visible = false
	
func pause():
	visible = true
	get_tree().paused = true
	print_debug("А тут ", get_tree().paused)
	
func testEsc():
	if Input.is_action_just_pressed("exit") and get_tree().paused == false:
		print_debug("При нажатии раз ", get_tree().paused)
		pause()
	elif Input.is_action_just_pressed("exit") and get_tree().paused == true:
		print_debug("При нажатии два ", get_tree().paused)
		resume()

func _on_resume_pressed():
	resume()
	
func _on_save_pressed():
	SaveSystem.save_game()
	resume()

func _on_load_pressed():
	SaveSystem.load_game()
	resume()	

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	
func _process(delta):
	testEsc()
