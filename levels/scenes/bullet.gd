extends Area2D


func _process(delta: float) -> void:
	position += transform.x * 600 * delta

func _on_body_entered(body):
	print("Enemy killed!")
	
