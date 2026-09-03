extends Control

@onready var inspection_label_result: Label = $InspectionLabelResult

const BLACK_POTION = preload("res://scenes/black_potion.tscn")

func _ready() -> void:
	inspection_label_result.hide()
	pass

func _on_inspection_slot_toggle_label(data: ItemData, flag: bool) -> void:
	if flag:
		inspection_label_result.text = "El item " + data.name + " tiene " + str(data.efecto) + " de veneno"
		inspection_label_result.show()
	else:
		inspection_label_result.hide()

func _on_button_pressed() -> void:
	var total := 0
	var result_slot : Slot = null
	var used_slots: Array[Slot] = []
	var has_ingredients := false
	
	for slot in get_children():
		if slot is Slot:
			if slot.slot_type == Slot.SlotType.NORMAL and slot.item != null:
				total += slot.item.efecto
				used_slots.append(slot)
				has_ingredients = true
			elif slot.slot_type == Slot.SlotType.RESULTADO and slot.item == null:
				result_slot = slot
	prints(str(total))
	
	if has_ingredients and result_slot != null:
		var data := ItemData.new()
		data.scene = BLACK_POTION
		data.name = "Poción Negra"
		data.efecto = total
		result_slot.item = data
	
	for slot in used_slots:
			slot.item = null
	
	prints(str(total))
