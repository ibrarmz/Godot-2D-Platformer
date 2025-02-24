extends TextureProgressBar

@export var boss : CharacterBody2D

func _ready() -> void:
	boss.health_changed.connect(update)
	update()

func update() -> void:
	value = boss.lives * 100 / 10
