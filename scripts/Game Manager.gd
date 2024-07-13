extends Node

var score = 0
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
