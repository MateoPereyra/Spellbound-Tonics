class_name LootEffect extends StaticBody2D

@export var tipo_efecto : EffectData.EffectType
@export var efecto_min := 1
@export var efecto_max := 7

var efecto : int

func _ready() -> void:
	efecto = randi_range(efecto_min, efecto_max)
