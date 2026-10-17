class_name ItemDefinition extends Resource

enum Category { LOOT, POTION }

@export var name : String
@export var category : Category = Category.LOOT
@export var is_ingredient : bool = false
@export var icon : Texture2D

@export_category("Efectos")
@export var effect_ranges : Array[EffectRange] = []

func roll_effects() -> Array[EffectData]:
	var result : Array[EffectData] = []
	for r in effect_ranges:
		var e := EffectData.new()
		e.tipo = r.tipo
		e.valor = randi_range(r.min_value, r.max_value)
		result.append(e)
	return result
