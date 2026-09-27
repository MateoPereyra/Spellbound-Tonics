extends Node

var inventory_items : Array[ItemData] = []

const GAME_OVER = preload("res://scenes/UI/game_over.tscn")

var saved_money : int = 0
var current_day : int = 1
var rent_day : int = 6
var rent : int = 100
var renta_cobrada_hoy := false

func _ready() -> void:
	prints("Dia " + str(current_day))

func _process(_delta: float) -> void:
	if rent_day == 0 and !renta_cobrada_hoy:
		cobrar()

func next_day():
	current_day += 1
	rent_day -= 1
	renta_cobrada_hoy = false
	prints("Dia " + str(current_day))

func on_new_day():
	next_day()

func add_rent():
	rent = rent * (current_day / 7)

func cobrar():
	var player = get_tree().get_first_node_in_group("Player")
	if player == null:
		return
	
	add_rent()
	if player.can_pay(rent):
		player.pay(rent)
		renta_cobrada_hoy = true
	else:
		game_over()
	rent_day = 6

func game_over():
	var go_ui = GAME_OVER.instantiate()
	get_tree().current_scene.add_child(go_ui)

func restart_day_count():
	current_day = 1

func restart_saved_money():
	saved_money = 0
