extends CharacterBody2D

@export var SPEED : float
@export var jump_speed : float
@onready var animated_sprite = $Sprite
@export var coyote_time_duration = 0.2 # Tiempo en segundos
@export var jump_buffer_duration = 0.15 # Tiempo en segundos
var jump_buffer_timer = 0.0
var coyote_timer = 0.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var FALL_GRAVITY = 1480
var is_facing_right = true

signal enemy_stomped(enemy: Node2D) 

func _physics_process(delta: float) -> void:
	update_animation()
	jump(delta)
	move_x()
	
	move_and_slide()

func update_animation():
	if velocity.x: #SI EL PERSONAJE SE MUVE EN EL EJE X
		animated_sprite.play("run")
	else: # SI EL PERSONAJE NO SE MUEVE
		animated_sprite.play("idle")

func flip():
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0) :
		scale.x *= -1
		is_facing_right = not is_facing_right

func move_x():
	var direction = Input.get_axis("move_left", "move_rigth")
	velocity.x = direction * SPEED
	flip()
	
func jump(delta):
	if is_on_floor():
		coyote_timer = coyote_time_duration 
	else:
		coyote_timer -= delta 
	
	if not is_on_floor():
		velocity.y += get_custom_gravity() * delta
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5 
	
	# Almacena el input de salto
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_duration
	
	# Decrementa el temporizador del buffer
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	
	# Salta si está en el suelo o si está en tiempo de Coyote o si está dentro del Input Buffer
	if (is_on_floor() or coyote_timer > 0) and jump_buffer_timer > 0:
		$AudioStreamPlayer2D.play(0)
		velocity.y = -jump_speed
		coyote_timer = 0  
		jump_buffer_timer = 0  # Resetea el buffer al saltar


func get_custom_gravity():
		if velocity.y < 0:
			return gravity
		return FALL_GRAVITY

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies") and velocity.y > 0:
		Global.score += body.score
		body.lives -= 1
		$AudioStreamPlayer2D.play(0)
		
		emit_signal("enemy_stomped", body) # Emitir la señal y pasar el enemigo
		
		if body.is_in_group("Boss"):
			velocity.y = -jump_speed * 2
	
		if not body.is_in_group("Boss"):
			velocity.y = -jump_speed * 0.5
