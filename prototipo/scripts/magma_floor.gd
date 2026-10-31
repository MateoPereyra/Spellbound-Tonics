extends Spell

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var damage := 25
@export var hit_ratio := 0.5

var targets : Array[Node2D] = []

func _ready() -> void:
	audio.pitch_scale = randf_range(0.5, 1.2)

func _process(delta: float) -> void:
	hit_ratio -= delta
	
	if hit_ratio <= 0:
		for target in targets:
			hit(target)
		hit_ratio = 0.5

func cast(caster: Node2D, origin: Vector2, target: Vector2) -> void:
	global_position = target

func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Enemy"):
		#hit(body)
	targets.append(body)

func hit(target:Node2D):
	target.take_damage(damage)

func _on_timer_timeout() -> void:
	call_deferred("queue_free")

func _on_body_exited(body: Node2D) -> void:
	if body in targets:
		targets.erase(body)
