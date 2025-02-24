extends Node2D

@onready var animation_win = $AnimationPlayer;
@onready var win_label = $CanvasLayer/win_label
@onready var score_label = $CanvasLayer/Label

func _ready() -> void:
	score_label.visible = false
	win_label.visible = true
	animation_win.play("you_win")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	score_label.text = str("SCORE: ", Global.score)
	score_label.visible = true;
