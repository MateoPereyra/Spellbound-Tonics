extends CharacterBody2D

@export var dialogue_file : DialogueResource
@onready var label: Label = $Label

var can_interact = false
var talking = false

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	label.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if dialogue_file != null and not talking:
			start_dialogue()
			for node in get_tree().get_nodes_in_group("Enchanter"):
				if node.is_in_group("ProgressBar"):
					node.value += 5

func start_dialogue():
	DialogueManager.show_dialogue_balloon(dialogue_file, "start") #El start es opcional
	talking = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
		label.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false
		label.hide()

func on_dialogue_ended(_dialogue):
	talking = false
