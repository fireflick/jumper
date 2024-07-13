extends Node2D

@onready var start_button = $Control/StartButton

func _ready():
	start_button.grab_focus()

func _on_button_pressed():
	GameManager.start_game()


func _on_button_2_pressed():
	GameManager.quit_game()
