extends Control

@onready var score_label = $Score
@onready var lives_label = $Lives

func _process(delta: float) -> void:
	score_label.text = str("SCORE:", Global.score)
	lives_label.text = str("LIVES:", Global.lives)
