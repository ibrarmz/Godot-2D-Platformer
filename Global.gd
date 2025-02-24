extends Node

var score = 18350
var lives = 3

func decrease_life():
	lives -= 1
	if lives > 0:
		call_deferred("reload_scene")
	else:
		reset_game()

func reload_scene():
	get_tree().reload_current_scene()

func reset_game():
	lives = 3
	score = 0
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
