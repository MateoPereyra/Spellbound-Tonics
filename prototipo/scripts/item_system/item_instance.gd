class_name ItemInstance extends Resource

@export var definition : ItemDefinition
@export var effects : Array[EffectData] = []

static func create(def: ItemDefinition) -> ItemInstance:
	var inst := ItemInstance.new()
	inst.definition = def
	inst.effects = def.roll_effects()
	return inst

static func create_potion(def: ItemDefinition, effect: Array[EffectData]) -> ItemInstance:
	var inst := ItemInstance.new()
	inst.definition = def
	inst.effects = effect
	return inst
