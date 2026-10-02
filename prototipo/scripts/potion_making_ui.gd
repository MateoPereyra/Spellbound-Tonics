extends Control

@onready var inspection_label_result: Label = $InspectionLabelResult
#@export var potion : PackedScene
@export var potion_scenes : Array[PackedScene] = []

func _ready() -> void:
	inspection_label_result.hide()

func _on_inspection_slot_toggle_label(data: ItemData, flag: bool) -> void:
	if flag:
		var texto = "El item " + data.name + " tiene:\n"
		for efecto in data.efectos:
			texto += EffectData.EffectType.keys()[efecto.tipo] + ": " + str(efecto.valor) + "\n"
		inspection_label_result.text = texto
		inspection_label_result.show()
	else:
		inspection_label_result.hide()

func _on_button_pressed() -> void:
	var sumas := {} 
	var result_slot : Slot = null
	var used_slots : Array[Slot] = []
	
	for slot in get_children():
		if slot is Slot:
			if slot.slot_type == Slot.SlotType.NORMAL and slot.item != null:
				used_slots.append(slot)
				for efecto in slot.item.efectos:
					if sumas.has(efecto.tipo):
						sumas[efecto.tipo] += efecto.valor
					else:
						sumas[efecto.tipo] = efecto.valor
			elif slot.slot_type == Slot.SlotType.RESULTADO and slot.item == null:
				result_slot = slot
	
	if result_slot != null and not sumas.is_empty():
		var data := ItemData.new()
		#data.scene = potion
		var tipo_dominante = get_dominant_type(sumas)
		data.scene = potion_scenes[tipo_dominante]
		data.name = "Poción"
		data.efectos = []
		
		for tipo in sumas.keys():
			var e := EffectData.new()
			e.tipo = tipo
			e.valor = sumas[tipo]
			data.efectos.append(e)
		
		result_slot.item = data
		for slot in used_slots:
			slot.item = null

func get_dominant_type(sumas: Dictionary) -> int:
	var mejor_tipo := -1
	var mejor_valor := -1
	for tipo in sumas.keys():
		if sumas[tipo] > mejor_valor:
			mejor_valor = sumas[tipo]
			mejor_tipo = tipo
	return mejor_tipo
