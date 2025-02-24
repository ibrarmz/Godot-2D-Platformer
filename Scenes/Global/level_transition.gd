extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animtion_player = $AnimationPlayer

func _ready() -> void:
	color_rect.visible = false
	animtion_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(animation_name):
	if animation_name == "fade_to_black":
		on_transition_finished.emit()
		animtion_player.play("fade_to_normal")
	elif animation_name == "fade_to_normal":
		color_rect.visible = false

func transition():
	color_rect.visible = true
	animtion_player.play("fade_to_black")
