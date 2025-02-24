extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	if(body.is_in_group("Player")):
		Global.decrease_life()

func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play()
