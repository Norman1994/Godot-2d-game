extends Control

func _ready():
	visible = false
	get_tree().paused = false
	
func resume():
	if get_tree() == null:
		await Engine.get_main_loop().process_frame
	if get_tree() != null:
		get_tree().paused = false
	visible = false
	
func pause():
	visible = true
	get_tree().paused = true
	print_debug("Тут ", get_tree().paused)
	
	
func testEsc():
	if Input.is_action_just_pressed("exit") and visible == false:
		pause()
	elif Input.is_action_just_pressed("exit") and visible == true:	
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
