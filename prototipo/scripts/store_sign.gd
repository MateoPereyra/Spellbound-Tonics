extends StaticBody2D

@onready var timer_4npc: Timer = $Timer4NPC

signal new_customer(orden: int)

var can_interact := false
var timer_on := false

func _ready() -> void:
	for npc in get_tree().get_nodes_in_group("NPC"):
		new_customer.connect(npc._on_store_sign_new_customer)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if not timer_on:
			timer_4npc.start()
			timer_on = true
		else:
			timer_4npc.stop()
			timer_on = false

func _on_timer_4npc_timeout() -> void:
	var orden = randi_range(1, 2)
	new_customer.emit(orden)
	prints(str(orden) + " npc")

func _on_interaction_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#prints("Entro a cartel")
		can_interact = true

func _on_interaction_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#prints("Salio a cartel")
		can_interact = false
