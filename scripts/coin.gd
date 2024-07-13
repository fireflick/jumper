extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var game_manager = GameManager

func _on_body_entered(body):
	var game_manager = GameManager
	game_manager.add_score(1)
	animation_player.play("Pick_upAnimation")
