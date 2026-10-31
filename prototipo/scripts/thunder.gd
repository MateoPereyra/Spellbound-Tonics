extends Spell

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var damage := 25

func _ready() -> void:
	audio.pitch_scale = randf_range(0.5, 1.2)

func cast(caster: Node2D, origin: Vector2, target: Vector2) -> void:
	global_position = target

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		hit(body)

func hit(target:Node2D):
	target.take_damage(damage)

func _on_animated_sprite_2d_animation_finished() -> void:
	call_deferred("queue_free")
