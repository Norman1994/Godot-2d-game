extends Area2D

var isTaken:bool = false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func on_pickup(body):
	if isTaken:
		return
		
	isTaken = true
	
	var tween_one = get_tree().create_tween()
	var tween_two = get_tree().create_tween()
	tween_one.tween_property($".", "position:y", position.y - 20, 0.7)
	tween_two.tween_property($AnimatedSprite2D, "self_modulate:a", 0.0, 0.7)
	
	GlobalVars.score += 1

	if (GlobalVars.score > GlobalVars.hi_score):
		GlobalVars.hi_score = GlobalVars.score
		$TakeSound.play()
		
	await tween_one.finished
	await tween_two.finished
	queue_free()
	
	
