extends Area2D

var launch_force: Vector2 = Vector2(0, -500) # Adjust the force as needed

func _on_body_entered(body):
	if body.has_method("launch"): # Ensure the player has the launch method
		body.launch(launch_force)
		
		
		
		
