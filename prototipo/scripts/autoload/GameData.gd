extends Node

signal scene_changing

var just_started := true

var inventory_items : Array[ItemInstance] = []
var in_table_items : Dictionary = {}

const GAME_OVER = preload("res://scenes/UI/game_over.tscn")

var saved_money : int = 0
var current_day : int = 1
#var rent_day : int = 6
#var rent : int = 0
#var renta_cobrada_hoy := false
var rent : int:
	get:
		return 100 * (floori((current_day - 1) / 7.0) + 1)

#region Para NPCs

#region Para misiones
#Para guardar y cargar
var item_guardado : ItemDefinition = null
var pago_guardado : int = 0
var on_mission := false
#endregion

func _ready() -> void:
	prints("Dia " + str(current_day))

#func _process(_delta: float) -> void:
	#if rent_day == 0 and !renta_cobrada_hoy:
		#cobrar()

func is_rent_day() -> bool:
	return current_day % 7 == 0

func days_until_rent() -> int:
	return (7 - current_day % 7) % 7

#func next_day():
	#current_day += 1
	#rent_day -= 1
	#renta_cobrada_hoy = false
	#prints("Dia " + str(current_day))

#func on_new_day():
	#next_day()

func on_new_day() -> void:
	if is_rent_day() and not cobrar():
		return
	next_day()

func next_day() -> void:
	current_day += 1
	prints("Dia " + str(current_day))

#func add_rent():
	#rent += 100

func cobrar() -> bool:
	var player = get_tree().get_first_node_in_group("Player")
	if player == null:
		return false
		
	if player.can_pay(rent):
		player.pay(rent)
		return true
	
	game_over()
	return false

func pay_player(amount: int):
	var player = get_tree().get_first_node_in_group("Player")
	if player == null:
		return
	
	player.update_money(amount)

func game_over():
	var go_ui = GAME_OVER.instantiate()
	get_tree().current_scene.add_child(go_ui)
	just_started = true

func restart_day_count():
	current_day = 1

func restart_saved_money():
	saved_money = 0

func change_scene(path: String) -> void:
	scene_changing.emit()
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	await get_tree().process_frame

func restart_mission_vars():
	item_guardado = null
	pago_guardado = 0

#func update_affection(name: String) -> void: Tengo que pensar bien esto
	#for node in get_tree().get_nodes_in_group(name):
				#if node.is_in_group("ProgressBar"):
					#node.value += 5
	#pass
