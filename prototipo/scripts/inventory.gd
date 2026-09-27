extends Control

signal inventory_filled()

func _ready() -> void:
	load_inventory()

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

func save_inventory() -> void:
	GameData.inventory_items.clear()
	for slot in get_slots():
		GameData.inventory_items.append(slot.item)

func load_inventory() -> void:
	var slots = get_slots()
	for i in GameData.inventory_items.size():
		if i < slots.size():
			slots[i].item = GameData.inventory_items[i]
