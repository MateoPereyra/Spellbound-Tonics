extends Control

signal inventory_filled()

func _on_nyx_picked(item_data: ItemData) -> void:
	var slots = $PanelContainer/GridContainer.get_children()
	
	for i in slots.size():
		var slot : Slot = slots[i]
		if slot.item == null:
			slot.item = item_data
			if i == slots.size() - 1:
				inventory_filled.emit()
			return

func get_slots() -> Array:
	return $PanelContainer/GridContainer.get_children()
