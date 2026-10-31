extends Enemy

const WORLD_ITEM = preload("uid://c4k0hvn78cney")

#@onready var walking_aud: AudioStreamPlayer2D = $walking
#@onready var attacking_aud: AudioStreamPlayer2D = $attacking

var is_attack_anim_playing := false

func _ready() -> void:
	generar_nuevo_destino()

func _physics_process(_delta: float) -> void:
	if not enemie_on_sight:
		movimiento()
	else:
		move_to_attack()
	update_anim()
	#update_walk_sound()

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
	#Mientras este la animación de ataque no se pisa
	if is_attack_anim_playing:
		return
	
	#Esta pegado al jugador esperando el cooldown, sin caminar
	if attacking:
		anim.play("idle")
		return
	
	var dir_anim = "idle"
	
	if (direction.x <= -0.5):
		dir_anim = "walk_left"
	elif (direction.x >= 0.5):
		dir_anim = "walk_right"
	elif (direction.y <= -0.5):
		dir_anim = "walk_up"
	elif (direction.y >= 0.5):
		dir_anim = "walk_down"
	
	anim.play(dir_anim)

func die():
	var world_item : WorldItem = WORLD_ITEM.instantiate()
	world_item.item = ItemInstance.create(loot)
	world_item.global_position = global_position
	self.get_parent().call_deferred("add_child", world_item)
	call_deferred("queue_free")

func move_to_attack():
	direction = (objetive.global_position - global_position).normalized()
	
	var distance = global_position.distance_to(objetive.global_position)
	
	if !attacking:
		velocity = direction * velocidad
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		if attack_cd.is_stopped():
			#attacking_aud.pitch_scale = randf_range(0.8, 1.7)
			#attacking_aud.play()
			play_attack_anim()
			objetive.take_damage(damage)
			attack_cd.start()

func play_attack_anim():
	is_attack_anim_playing = true
	anim.play("attack_" + get_side()) 

func get_side() -> String:
	if abs(direction.x) > abs(direction.y):
		return "right" if direction.x > 0 else "left"
	return "down" if direction.y > 0 else "up"

func take_damage(amount : int):
	health -= amount
	if health <= 0:
		die()

#func update_walk_sound() -> void:
	#if velocity.length() > 1.0:
		#if not walking_aud.playing:
			#walking_aud.pitch_scale = randf_range(0.7, 1.7)
			#walking_aud.play()
	#elif walking_aud.playing:
		#walking_aud.stop()

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		enemie_on_sight = true
		objetive = body

func _on_detection_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		enemie_on_sight = false
		objetive = null

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body == objetive:
		attacking = true

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body == objetive:
		attacking = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation.begins_with("attack_"):
		is_attack_anim_playing = false
