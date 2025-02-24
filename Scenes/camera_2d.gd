extends Camera2D

@export var follow_threshold := 100  # Punto donde la cámara empieza a moverse (relativo al jugador)

var level_limit_x = 0  # Límite derecho del nivel

func _ready():
	var level = get_parent().get_parent()  # Suponiendo que el nivel está como el abuelo del Player
	if level and level.has_node("CameraLimit"):
		level_limit_x = level.get_node("CameraLimit").global_position.x  # Usa el límite si lo tienes como un nodo
		self.limit_right = level_limit_x

func _process(delta):
	var player_x = get_parent().global_position.x
	
	# La cámara sigue al jugador solo cuando se acerca al borde (simulando el borde de la pantalla)
	if player_x > follow_threshold:
		global_position.x = player_x
			
