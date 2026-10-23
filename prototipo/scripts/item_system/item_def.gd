class_name ItemDefinition extends Resource

enum Category { LOOT, POTION }

@export var name : String
@export var category : Category = Category.LOOT
@export var is_ingredient : bool = false
@export var icon : Texture2D

@export_category("Efectos")
@export var first_effect : EffectData.EffectType = EffectData.EffectType.NONE
@export var second_effect : EffectData.EffectType = EffectData.EffectType.NONE
@export var first_range : EffectRange
@export var total_points = 100


func roll_effects() -> Array[EffectData]:
	var result : Array[EffectData] = []
	if first_effect == EffectData.EffectType.NONE:
		return result
	
	var first := EffectData.new()
	first.tipo = first_effect
	
	if first_effect == second_effect:
		second_effect = EffectData.EffectType.NONE
	
	if second_effect == EffectData.EffectType.NONE:
		first.valor = total_points
		result.append(first)
		return result
	
	if first_range == null:
		push_warning(name + ": tiene dos efectos pero no tiene first_range.")
		first.valor = total_points
		result.append(first)
		return result
	
	first.valor = randi_range(first_range.min_value, first_range.max_value)
	result.append(first)
	
	var second := EffectData.new()
	second.tipo = second_effect
	second.valor = total_points - first.valor
	result.append(second)
	return result
