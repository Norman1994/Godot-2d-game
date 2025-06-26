extends Node

const SAVE_PATH = "res://SaveData/savegame.cfg"

var config = ConfigFile.new()
var player = GlobalVars.current_player

var loaded_data: Dictionary = {}

func get_save_data() -> Dictionary:
	var player = GlobalVars.current_player
	if player == null:
		print_debug("Не найден пользователь")
		return{}
	
	var loaded_data ={
		"player_position": [player.position.x, player.position.y],
		"score": GlobalVars.score,
		"hi_score": GlobalVars.hi_score,
		"current_level": get_tree().current_scene.scene_file_path
	}
	
	return loaded_data
	
func apply_save_data(loaded_data: Dictionary) -> void:
	var player = GlobalVars.current_player
	if player == null:
		return
		
	var pos_arr = loaded_data.get("player_position", [0, 0])
	GlobalVars.current_player_position = Vector2(pos_arr[0], pos_arr[1])
	
	GlobalVars.score = loaded_data.get("score", 0)
	GlobalVars.hi_score = loaded_data.get("hi_score", 0)
	
	print_debug("Позиция игрока ", GlobalVars.current_player_position)
	
func save_game():
	var save_data = get_save_data()
	if save_data.is_empty():
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	print_debug(save_data)
	
func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	var parsed = JSON.parse_string(content)
	if parsed is Dictionary:
		var scene_path = parsed.get("current_level", "")
		if scene_path != "":
			get_tree().change_scene_to_file(scene_path)
			await get_tree().process_frame
			print_debug("А теперь загрузим тут!")
			while GlobalVars.current_player == null:
				await get_tree().process_frame
			GlobalVars.position_load = true
			apply_save_data(parsed)
		else:
			print_debug("Нет сцены в сохранении")
	else:
		print_debug("Ошибка")
	
	
