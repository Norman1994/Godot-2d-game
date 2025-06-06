extends Control

@onready var score = $MarginContainer/Score
@onready var hi_score = $MarginContainer2/HiScore

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not score:
		return
	score.text = "Очки: " + str(GlobalVars.score)
	hi_score.text = "Рекорд: " + str(GlobalVars.hi_score)
