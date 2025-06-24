extends Node

const SAVE_PATH = "res://SaveData/savegame.cfg"

var config = ConfigFile.new()
var player = GlobalVars.current_player

func get_save_data() -> Dictionary:
	var player = GlobalVars.current_player
	if player == null:
		print_debug("Не найден пользователь")
		return{}
	
	var data ={
		"player_position": [player.position.x, player.position.y],
		"score": GlobalVars.score,
		"hi_score": GlobalVars.hi_score
	}
	
	return data
	
func apply_save_data(data: Dictionary) -> void:
	var player = GlobalVars.current_player
	if player == null:
		return
		
	var pos_arr = data.get("player_position", [0, 0])
	player.position = Vector2(pos_arr[0], pos_arr[1])
	
	GlobalVars.score = data.get("score", 0)
	GlobalVars.hi_score = data.get("hi_score", 0)
	
func save_game():
	var save_data = get_save_data()
	if save_data.is_empty():
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	print_debug("Сохранено!")
	
func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	var parsed = JSON.parse_string(content)
	if parsed is Dictionary:
		apply_save_data(parsed)
	else:
		print_debug("Ошибка")
	
	
