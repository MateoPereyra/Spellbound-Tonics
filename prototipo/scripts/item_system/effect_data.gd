class_name EffectData extends Resource

enum EffectType { VENENO, CURACION, RESISTENCIA, FUERZA, DEBILIDAD, NONE }

const OPPOSITES := {
	EffectType.VENENO : EffectType.CURACION,
	EffectType.DEBILIDAD : EffectType.FUERZA,
}

@export var tipo : EffectType
@export var valor : int

static func get_opposite(eff: EffectType) -> EffectType:
	if OPPOSITES.has(eff):
		return OPPOSITES[eff]
	var key = OPPOSITES.find_key(eff)
	if key != null:
		return key
	return EffectType.NONE

static func cancel_opposites(sumas: Dictionary) -> Dictionary:
	var result := sumas.duplicate()
	for type in sumas.keys():
		var opuesto = get_opposite(type)
		if opuesto != EffectType.NONE and result.has(type) and result.has(opuesto):
			var absoluto = result[type] - result[opuesto]
			result.erase(type)
			result.erase(opuesto)
			if absoluto > 0:
				result[type] = absoluto
			elif absoluto < 0:
				result[opuesto] = -absoluto
	return result
