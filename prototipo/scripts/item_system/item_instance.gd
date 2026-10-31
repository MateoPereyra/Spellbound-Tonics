class_name ItemInstance extends Resource

@export var definition : ItemDefinition
@export var effects : Array[EffectData] = []

var rarity : String

static func create(def: ItemDefinition) -> ItemInstance:
	var inst := ItemInstance.new()
	inst.definition = def
	inst.rarity = def.get_rarity()
	inst.effects = def.roll_stats(inst.rarity)
	#prints(inst.rarity)
	return inst

static func create_potion(def: ItemDefinition, effect: Array[EffectData]) -> ItemInstance:
	var inst := ItemInstance.new()
	inst.definition = def
	inst.effects = effect
	return inst
