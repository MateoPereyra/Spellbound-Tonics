extends Area2D

@export var damage := 25
@export var speed := 300

var direction : Vector2 = Vector2.ZERO: 
	set(value):
		direction = value
		rotation = direction.angle() + PI / 2

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		hit(body)
		call_deferred("queue_free")

func hit(target:Node2D):
	target.health -= damage
	if target.health <= 0:
		target.die()

func _on_timer_timeout() -> void:
	queue_free()
