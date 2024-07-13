extends Area2D

@onready var timer = $Timer
@onready var door_sprite_2d = $DoorSprite2D
@onready var door_open_sound = $DoorOpenSound

func _on_body_entered(body):
	door_sprite_2d.play()
	door_open_sound.play()
	GameManager.add_score(7)
	timer.start()

func _on_timer_timeout():
	GameManager.next_level()
