extends Area2D

@export_file("*.tscn") var new_scene: String

@onready var label: Label = $Label

var can_interact := false

func _ready() -> void:
	label.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		load_new_scene()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
		label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false
		label.hide()

func load_new_scene():
	if new_scene != "":
		var nyx = get_tree().get_first_node_in_group("Player")
		nyx.get_node("CanvasLayer/Inventory").save_inventory()
		nyx.save_money()
		get_tree().change_scene_to_file(new_scene)
