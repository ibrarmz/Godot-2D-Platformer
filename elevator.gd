extends CharacterBody2D

@export var move_distance : float  # Cuánto se mueve arriba y abajo
@export var speed : float  # Velocidad de la plataforma

var direction := 1
var start_position

func _ready():
	start_position = global_position

func _physics_process(delta):
	velocity.y = direction * speed
	move_and_slide()

	if move_distance > 0: 
		# Cambia dirección al llegar al límite
		if global_position.y > start_position.y or global_position.y <= start_position.y - move_distance:
			direction *= -1
	else:
		# Cambia dirección al llegar al límite
		if global_position.y > start_position.y - move_distance or global_position.y <= start_position.y:
			direction *= -1
