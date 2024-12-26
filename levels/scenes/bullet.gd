extends Area2D

@onready var game_manager = GameManager
@onready var enemy_kill_sound: AudioStreamPlayer2D = $enemyKillSound

func _process(delta: float) -> void:
	position += transform.x * 600 * delta

func _on_body_entered(body):
	if body.name.begins_with("slime"):
		game_manager.add_score(10)
		enemy_kill_sound.play()
		body.queue_free()
	queue_free()
