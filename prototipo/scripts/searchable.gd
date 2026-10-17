extends Area2D

const WORLD_ITEM = preload("uid://c4k0hvn78cney")

@onready var can_search := false
@onready var label: Label = $Label
@onready var on_cd := false

@export var loot_pool : Array[ItemDefinition] = []

func _ready() -> void:
	label.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if can_search and not on_cd:
			for definition in loot_pool:
				var world_item : WorldItem = WORLD_ITEM.instantiate()
				world_item.item = ItemInstance.create(definition)
				get_parent().add_child(world_item)
				var offset = Vector2(randf_range(-100, 100), randf_range(-100, 100))
				world_item.global_position = global_position + offset
				on_cd = true
				$Timer.start()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_search = true
		label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_search = false
		label.hide()

func _on_timer_timeout() -> void:
	on_cd = false
