extends StaticBody2D

@onready var can_interact := false
const BLACK_POTION = preload("res://scenes/black_potion.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		check_inventory()

func _on_interaction_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
		prints("Entro")
	
	if body.is_in_group("NPC"):
		var extra = 0
		for slot in $Node2D.get_children():
			if slot is Slot and slot.item != null:
				extra += slot.item.efecto
				var extra_total = 10 * (extra/5)
				slot.item = null
				prints("Vendido")
				var nyx = get_tree().get_first_node_in_group("Player")
				nyx.potion_bought(50 + extra_total)

func _on_interaction_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false
		prints("Salio")

func check_inventory():
	var inventory = get_tree().get_first_node_in_group("Inventory")
	if inventory == null:
		return

	for slot in inventory.get_slots():
		if slot is Slot and slot.item != null:
			if slot.item.scene == BLACK_POTION:
				print("Slot con item: ", slot.item.name, " | efecto: ", slot.item.efecto)
				asignar_a_slot_de_venta(slot.item, slot)

func asignar_a_slot_de_venta(item_data: ItemData, slot_origen: Slot) -> void:
	for slot in $Node2D.get_children():
		if slot is Slot and slot.item == null:
			slot.item = item_data
			slot_origen.item = null
			prints("Listo")
			return
