extends CharacterBody2D

@export var dialogue_file : DialogueResource
@export var items_a_pedir : Array[PackedScene] = []
@export var pagos_de_mision : Array[int] = []
@export var nombres_de_items: Array[String] = []
@export var dialogos_disponibles : Array[String] = []

@onready var label: Label = $Label

var can_interact = false
var talking = false

var item_pedido : PackedScene = null
var pago : int = 0
var nombre_pedido : String
var indice : int = 0
var inventory

func _ready() -> void:
	GameData.scene_changing.connect(_on_scene_changing)
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	
	label.hide()
	
	load_mission_vars()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if dialogue_file != null and not talking:
			start_dialogue()
			for node in get_tree().get_nodes_in_group("Hunter"):
				if node.is_in_group("ProgressBar"):
					node.value += 5

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
		label.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false
		label.hide()

func start_dialogue():
	if !GameData.on_mission:
		var rand = randi_range(0, dialogos_disponibles.size() - 1)
		DialogueManager.show_dialogue_balloon(dialogue_file, dialogos_disponibles[rand], [self])
	elif GameData.on_mission:
		var instancia = get_tree().get_first_node_in_group("Inventory")
		inventory = instancia
		DialogueManager.show_dialogue_balloon(dialogue_file, "on_mission", [self, inventory])
	talking = true

func on_dialogue_ended(_dialogue):
	talking = false

func set_mission_vars():
	indice = randi_range(0, items_a_pedir.size() - 1)
	item_pedido = items_a_pedir[indice]
	pago = pagos_de_mision[indice]
	nombre_pedido = nombres_de_items[indice]
	GameData.on_mission = true

func save_mission_vars():
	GameData.item_guardado = item_pedido
	GameData.pago_guardado = pago
	GameData.nombre_guardado = nombre_pedido

func load_mission_vars():
	item_pedido = GameData.item_guardado
	pago = GameData.pago_guardado
	nombre_pedido = GameData.nombre_guardado
	GameData.restart_mission_vars()

func _on_scene_changing() -> void:
	save_mission_vars()

func can_complete_mission():
	for slot in inventory.get_slots():
		if slot is Slot and slot.item != null:
			if slot.item.scene == item_pedido:
				slot.item = null
				return true

func complete_mission():
	GameData.pay_player(pago)
	item_pedido = null
	pago = 0
	nombre_pedido = ""
	GameData.on_mission = false
