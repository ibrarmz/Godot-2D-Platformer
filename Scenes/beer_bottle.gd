extends Area2D

@onready var animation = $AnimationPlayer

func _ready() -> void:
	self.visible = false;
	self.set_monitoring(false) # Desactiva la detección de colisiones

func _on_boss_boss_death() -> void:
	animation.play("deafault")
	self.visible = true;
	self.set_monitoring(true) # Activa la detección de colisiones cuando se haga visible


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		LevelTransition.transition()
		
		# Conectar la señal para esperar la transición
		LevelTransition.on_transition_finished.connect(_on_transition_finished)

func _on_transition_finished() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/you_win.tscn")
