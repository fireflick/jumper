extends CanvasLayer

@onready var game_manager = GameManager
@onready var score_label = $ScoreLabel

func _ready():
	game_manager.connect("score_updated", Callable(self, "_on_score_updated"))
	_on_score_updated()
	
func _on_score_updated():
	score_label.text = "Score: " + str(game_manager.score)
	print("Score updated")
