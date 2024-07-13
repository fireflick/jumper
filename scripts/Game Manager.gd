extends Node

var score = 0
const FILE_BEGIN = "res://levels/level_"

signal score_updated()

func add_score(amount):
	score += amount
	emit_signal("score_updated")

func death():
	score = 0

func start_game():
	score = 0
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func quit_game():
	get_tree().quit()

func next_level():
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)
