extends Control

@onready var inspection_label_result: Label = $InspectionLabelResult

@export_group("Pociones por tipo y valor (2: <10 y >10)")
@export var potions_veneno : Array[ItemDefinition] = []
@export var potions_curacion : Array[ItemDefinition] = []
@export var potions_resistencia : Array[ItemDefinition] = []
@export var potions_fuerza : Array[ItemDefinition] = []
@export var potions_debilidad : Array[ItemDefinition] = []
@export var potions_mixed : Array[ItemDefinition] = []

var has_veneno := false
var has_curacion := false
var has_resistencia := false
var has_fuerza := false
var has_debilidad := false
var is_mixed := false

func _ready() -> void:
	inspection_label_result.hide()

func _on_inspection_slot_toggle_label(item: ItemInstance, flag: bool) -> void:
	if flag and item != null:
		var texto = item.definition.name + " tiene:\n"
		for efecto in item.effects:
			texto += EffectData.EffectType.keys()[efecto.tipo] + ": " + str(efecto.valor) + "\n"
		inspection_label_result.text = texto
		inspection_label_result.show()
	else:
		inspection_label_result.hide()

func _on_button_pressed() -> void:
	reset_flags()
	if inspection_label_result.visible:
		inspection_label_result.hide()
	
	var sumas := {} 
	var result_slot : Slot = null
	var used_slots : Array[Slot] = []
	
	for slot in get_children():
		if slot is Slot:
			if slot.slot_type == Slot.SlotType.INGREDIENTE and slot.item != null:
				used_slots.append(slot)
				for efecto in slot.item.effects:
					sumas[efecto.tipo] = sumas.get(efecto.tipo, 0) + efecto.valor
			elif slot.slot_type == Slot.SlotType.RESULTADO and slot.item == null:
				result_slot = slot
	
	if used_slots.size() < 2:
		inspection_label_result.text = "Necesitas al menos 2 ingredientes!"
		inspection_label_result.show()
		return
	
	if result_slot == null or sumas.is_empty():
		return
	
	sumas = EffectData.cancel_opposites(sumas)
	if sumas.is_empty():
		return
	
	var total_puntos := 0
	for tipo in sumas.keys():
		total_puntos += sumas[tipo]
		mark_type(tipo)
		
	resolve_mixed()
	
	var definicion := pick_definition(total_puntos)
	if definicion == null:
		push_warning("No hay definición de poción cargada para esta combinación.")
		return
	
	var efectos_finales : Array[EffectData] = []
	for tipo in sumas.keys():
		var e := EffectData.new()
		e.tipo = tipo
		e.valor = sumas[tipo]
		efectos_finales.append(e)
	
	for slot in used_slots:
		slot.item = null
	
	result_slot.item = ItemInstance.create_potion(definicion, efectos_finales)

func reset_flags() -> void:
	has_veneno = false
	has_curacion = false
	has_resistencia = false
	has_fuerza = false
	is_mixed = false

func mark_type(tipo: EffectData.EffectType) -> void:
	match tipo:
		EffectData.EffectType.VENENO:
			has_veneno = true
		EffectData.EffectType.CURACION:
			has_curacion = true
		EffectData.EffectType.RESISTENCIA:
			has_resistencia = true
		EffectData.EffectType.FUERZA:
			has_fuerza = true
		EffectData.EffectType.DEBILIDAD:
			has_debilidad = true

func resolve_mixed() -> void:
	var cantidad := 0
	for presente in [has_veneno, has_curacion, has_resistencia, has_fuerza, has_debilidad]:
		if presente:
			cantidad += 1
	
	if cantidad >= 2:
		is_mixed = true
		has_veneno = false
		has_curacion = false
		has_resistencia = false
		has_fuerza = false
		has_debilidad = false

func get_pool() -> Array[ItemDefinition]:
	if is_mixed:
		return potions_mixed
	if has_veneno:
		return potions_veneno
	if has_curacion:
		return potions_curacion
	if has_resistencia:
		return potions_resistencia
	if has_fuerza:
		return potions_fuerza
	if has_debilidad:
		return potions_debilidad
	var vacio : Array[ItemDefinition] = []
	return vacio

func pick_definition(total_puntos: int) -> ItemDefinition:
	var pool := get_pool()
	var indice := 1 if total_puntos > 10 else 0
	if indice >= pool.size():
		return null
	return pool[indice]
