extends Area2D

const FILE_BEGIN = "res://levels/level_"
@onready var game_manager = GameManager

func _on_body_entered(body):
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	print(next_level_path)
	game_manager.add_score(7)
	print("I hit the apple")
	get_tree().change_scene_to_file(next_level_path)
	
	
