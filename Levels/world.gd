extends Node2D

var save_message_receive : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SaveSystem.save_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
