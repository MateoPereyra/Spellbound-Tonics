extends CharacterBody2D

@onready var path_follow = get_parent()

@export var speed := 100
@export var orden_propio := 1 :
	set(value):
		orden_propio = clampi(value, 1, 7)

var direction: Vector2
var posicion_anterior: Vector2
var activado := false

func _ready() -> void:
	posicion_anterior = path_follow.global_position
	#prints(orden_propio)

func _physics_process(delta: float) -> void:
	if activado:
		walk_path(delta)

func walk_path(delta: float):
	path_follow.progress += delta * speed
	
	var pos = path_follow.global_position
	direction = (pos - posicion_anterior).normalized()
	posicion_anterior = pos
	
	if path_follow.progress_ratio >= 1.0:
		path_follow.progress = 0.0
		deactivate()

func activate():
	activado = true

func deactivate():
	activado = false

func _on_store_sign_new_customer(orden: int) -> void:
	if orden_propio == orden and not activado:
		activate()
