extends Node2D

@export var score : int

func _ready() -> void:
	$Area2D/AnimatedSprite2D.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		self.visible = false
		Global.score += score
		$AudioStreamPlayer2D.play()
	


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
