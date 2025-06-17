extends Node2D

@export var next_scene : String
@export var need_key : bool = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_door_animation_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
		
	if need_key: 
		if body.has_key:
			$OpenDoor.show()
			$DoorSound.play()

func _on_door_animation_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return
	$OpenDoor.hide()


func _on_go_to_next_level_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	if need_key: 
		if body.has_key:
			call_deferred("change_scene")
			
func change_scene():
	get_tree().change_scene_to_file(next_scene)
