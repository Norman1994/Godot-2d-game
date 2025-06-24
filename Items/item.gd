extends Area2D

enum type_enum {ITEM_FRUIT, ITEM_KEY, ITEM_BONUS, ITEM_JUMP}

var isTaken:bool = false
@export var points : int = 1
@export var type : type_enum

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
	$TakeSound.play()

	if (GlobalVars.score > GlobalVars.hi_score):
		GlobalVars.hi_score = GlobalVars.score

	await tween_one.finished
	await tween_two.finished
	
	match type:
		type_enum.ITEM_FRUIT:
			pass
		type_enum.ITEM_KEY:
			body.has_key = true
			print_debug(body.has_key)
		type_enum.ITEM_BONUS:
			pass
		type_enum.ITEM_JUMP:
			body.has_double_jump = true
	
	queue_free()
	
	
