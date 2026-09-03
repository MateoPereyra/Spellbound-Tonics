extends CharacterBody2D

@onready var attack_cd: Timer = $AttackCD

@export var velocidad := 100
@export var rango := 100
@export var health := 100
@export var damage := 5
@export var loot : PackedScene

var direction := Vector2.ZERO
var destino : Vector2
var has_destino := false
var espera := false
var enemie_on_sight := false
var objetive : Node2D

func _ready() -> void:
	generar_nuevo_destino()

func _physics_process(delta: float) -> void:
	if not enemie_on_sight:
		movimiento()
	else:
		move_to_attack()
	update_anim()

func generar_nuevo_destino():
	destino = global_position + Vector2(randf_range(-rango, rango), randf_range(-rango, rango))
	has_destino = true

func movimiento():
	if not has_destino:
		return
	
	direction = (destino - global_position).normalized()
	velocity = direction * velocidad
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		generar_nuevo_destino()
		return
	
	if global_position.distance_to(destino) < 5:
		has_destino = false
		velocity = Vector2.ZERO
		direction = Vector2.ZERO
		await get_tree().create_timer(3).timeout
		generar_nuevo_destino()
	
	if not espera:
			espera = true
			await get_tree().create_timer(3).timeout
			espera = false
			generar_nuevo_destino()

func update_anim():
	var dir_anim = "idle"
	
	if (direction.x <= -0.5):
		dir_anim = "walk_left"
	elif (direction.x >= 0.5):
		dir_anim = "walk_right"
	elif (direction.y <= -0.5):
		dir_anim = "walk_up"
	elif (direction.y >= 0.5):
		dir_anim = "walk_down"
		
	get_node("AnimatedSprite2D").play(dir_anim)

func die():
	var drop = loot.instantiate()
	drop.global_position = global_position
	self.get_parent().call_deferred("add_child", drop)
	call_deferred("queue_free")

func move_to_attack():
	direction = (objetive.global_position - global_position).normalized()
	
	var distance = global_position.distance_to(objetive.global_position)
	
	if distance > 10:
		velocity = direction * velocidad
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		if attack_cd.is_stopped():
			objetive.take_damage(damage)
			prints("Attacking")
			attack_cd.start()

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		enemie_on_sight = true
		objetive = body


func _on_detection_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		enemie_on_sight = false
		objetive = null
