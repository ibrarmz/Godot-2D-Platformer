extends CharacterBody2D

enum ENEMY_TYPE { NORMAL, BOSS }

signal health_changed
signal boss_death;

@export var SPEED : float = 100
@export var score : float = 100
@export var enemy_type : ENEMY_TYPE = ENEMY_TYPE.NORMAL
@export var lives : int = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := Vector2.LEFT # Empieza moviéndose hacia la izquierda

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	var player = get_tree().get_first_node_in_group("Player")  # Obtener al Player
	if player:
		player.enemy_stomped.connect(_on_enemy_stomped)  # Conectar la señal

func _physics_process(delta: float) -> void:
	is_dead()
	
	# Movimiento del enemigo
	velocity.x = SPEED * direction.x
	move_and_slide()
	
	# Detecta si choca con algo en la dirección que está moviéndose
	if $RayCastWall.is_colliding():
		change_direction()
	
	if not $RayCastFloor.is_colliding():
		change_direction()
		
	if not is_on_floor():
		velocity.y += gravity * delta

func change_direction() -> void:
	# Cambia la dirección al opuesto
	direction = -direction
	# Voltea al personaje visualmente
	scale.x *= -1

func is_dead():
	if(lives <= 0):
		if (enemy_type == ENEMY_TYPE.BOSS):
			emit_signal("boss_death")
		self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.queue_free()
		Global.decrease_life()
		
func _on_enemy_stomped(enemy: Node2D):
	if enemy == self:  # Asegurar que el evento es para este enemigo
		emit_signal("health_changed")
		$AnimatedSprite2D.play("hurt")  # Reproducir animación de daño
		await $AnimatedSprite2D.animation_finished  # Esperar un poco (ajusta el tiempo según la duración de "hurt")
		$AnimatedSprite2D.play("default")
