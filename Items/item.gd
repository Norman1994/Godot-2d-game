extends Area2D


func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func on_pickup(body):
	GlobalVars.score += 1
	if (GlobalVars.score > GlobalVars.hi_score):
		GlobalVars.hi_score = GlobalVars.score
	get_tree().queue_delete(self)
