extends Area2D

@onready var can_search := false
@onready var label: Label = $Label
@onready var on_cd := false

@export var loot_pool : Array[PackedScene] = []

func _ready() -> void:
	label.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if can_search and not on_cd:
			for loot in loot_pool.size():
				var drop = loot_pool[loot].instantiate()
				get_parent().add_child(drop)
				var offset = Vector2(randf_range(-100, 100), randf_range(-100, 100))
				drop.global_position = global_position + offset
				on_cd = true
				$Timer.start()
			prints("Interactuo")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_search = true
		label.show()
		prints("Entro")


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_search = false
		label.hide()
		prints("Salio")

func _on_timer_timeout() -> void:
	on_cd = false
	prints("Ya puede buscar")
