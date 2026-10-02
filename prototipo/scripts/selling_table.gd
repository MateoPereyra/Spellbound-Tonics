extends StaticBody2D

@export var table_id : int = 1
@onready var can_interact := false
@export var potions : Array[PackedScene] = []

func _ready() -> void:
	GameData.scene_changing.connect(_on_scene_changing)
	load_item_in_table()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		check_inventory()

func _on_interaction_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
	
	if body.is_in_group("NPC"):
		for slot in $Node2D.get_children():
			if slot is Slot and slot.item != null:
				var efecto_total := 0
				for efecto in slot.item.efectos:
					efecto_total += efecto.valor
				
				var extra_total = 10 * floori(efecto_total / 5.0)
				slot.item = null
				
				var nyx = get_tree().get_first_node_in_group("Player")
				nyx.potion_bought(50 + extra_total)

func _on_interaction_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false
		#prints("Salio")

func check_inventory():
	var inventory = get_tree().get_first_node_in_group("Inventory")
	if inventory == null:
		return

	for slot in inventory.get_slots():
		if slot is Slot and slot.item != null:
			if slot.item.scene in potions:
				asignar_a_slot_de_venta(slot.item, slot)

func asignar_a_slot_de_venta(item_data: ItemData, slot_origen: Slot) -> void:
	for slot in $Node2D.get_children():
		if slot is Slot and slot.item == null:
			slot.item = item_data
			slot_origen.item = null
			#prints("Listo")
			return

func save_items_in_table():
	var items : Array[ItemData] = []
	
	for slot in $Node2D.get_children():
		if slot is Slot and slot.item != null:
			items.append(slot.item)
	
	GameData.in_table_items[table_id] = items

func load_item_in_table():
	if not GameData.in_table_items.has(table_id):
		return
	
	var items = GameData.in_table_items[table_id]
	var slots = $Node2D.get_children()
	
	for i in items.size():
		if i < slots.size():
			slots[i].item = items[i]

func _on_scene_changing() -> void:
	save_items_in_table()
