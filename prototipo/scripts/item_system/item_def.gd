class_name ItemDefinition extends Resource

enum Category { LOOT, POTION }

var rarities := {
	"Comun" : {
		"Multiplicador" : 1.0,
		"Probabilidad" : 50.0 },
	"Raro" : {
		"Multiplicador" : 1.2,
		"Probabilidad" : 25.0 },
	"Unico" : {
		"Multiplicador" : 1.4,
		"Probabilidad" : 15.0 },
	"Fantastico" : {
		"Multiplicador" : 1.6,
		"Probabilidad" : 7.5 },
	"Hex" : {
		"Multiplicador" : 2.0,
		"Probabilidad" : 2.5 },
}

@export var name : String
@export var category : Category = Category.LOOT
@export var is_ingredient : bool = false
@export var icon : Texture2D

@export_category("Efectos")
@export var first_effect : EffectData.EffectType = EffectData.EffectType.NONE
@export var second_effect : EffectData.EffectType = EffectData.EffectType.NONE
@export var first_range : EffectRange
@export var base_total_points = 100

var total_points = 100
var rarity : String


func roll_stats() -> Array[EffectData]:
	prints(total_points)
	rarity = get_rarity()
	total_points = base_total_points * rarities[rarity]["Multiplicador"]
	prints(str(rarity) + " " + str(total_points))
	
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

func get_rarity() -> String:
	var probability = randf() * 100.0
	#prints(probability)
	var current_probability = 0.0
	
	for clave in rarities:
		current_probability += rarities[clave]["Probabilidad"]
		if probability < current_probability:
			return clave
	return "Comun"
