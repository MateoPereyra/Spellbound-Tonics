extends StaticBody2D

@export var poison_min := 1
@export var poison_max := 7

var efecto : int

func _ready() -> void:
	efecto = randi_range(poison_min, poison_max)
