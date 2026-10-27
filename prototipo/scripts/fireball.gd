extends Spell

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var damage := 25
@export var speed := 300

var direction : Vector2 = Vector2.ZERO:
	set(value):
		direction = value
		rotation = direction.angle() + PI / 2

func _ready() -> void:
	audio.pitch_scale = randf_range(0.5, 1.2)

func cast(caster: Node2D, origin: Vector2, target: Vector2) -> void:
	global_position = origin
	direction = (target - origin).normalized()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		hit(body)
		call_deferred("queue_free")

func hit(target: Node2D):
	target.take_damage(damage)

func _on_timer_timeout() -> void:
	queue_free()
