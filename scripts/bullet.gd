extends Area2D

@onready var game_manager = GameManager
@onready var enemy_kill_sound: AudioStreamPlayer2D = $enemyKillSound
@onready var timer: Timer = $Timer

var velocity: Vector2 = Vector2.ZERO  # The bullet's velocity

func _process(delta: float) -> void:
	position += velocity * delta  # Move based on velocity

func _on_body_entered(body):
	if body.name.begins_with("slime"):
		game_manager.add_score(10)
		enemy_kill_sound.play()
		body.queue_free()  # Remove the monster
	hide()
	timer.start(0.1)  # Set timer duration to match sound length	

func _on_timer_timeout():
	queue_free()  # Remove the bullet after the timer finishes
