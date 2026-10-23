class_name EffectData extends Resource

enum EffectType { VENENO, CURACION, RESISTENCIA, FUERZA, DEBILIDAD, NONE }

const OPPOSITES := {
	EffectType.VENENO : EffectType.CURACION,
	EffectType.DEBILIDAD : EffectType.FUERZA,
}

var rarity := {
	"Comun" : 1,
	"Raro" : 1.2
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
	for tipo in sumas.keys():
		var opuesto = get_opposite(tipo)
		if opuesto != EffectType.NONE and result.has(tipo) and result.has(opuesto):
			var absoluto = result[tipo] - result[opuesto]
			result.erase(tipo)
			result.erase(opuesto)
			if absoluto > 0:
				result[tipo] = absoluto
			elif absoluto < 0:
				result[opuesto] = -absoluto
	return result
