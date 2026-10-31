class_name Spell extends Area2D

@export var cooldown := 0.5

func cast(caster: Node2D, origin: Vector2, target: Vector2) -> void:
	push_warning(name + ": este hechizo no implementó cast().")
