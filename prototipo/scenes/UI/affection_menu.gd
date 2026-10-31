extends Control

func _ready() -> void:
	GameData.affection_changed.connect(_on_affection_changed)
	for npc in GameData.affection.keys():
		_set_bar(npc, GameData.affection[npc])

func _on_affection_changed(npc: String, value: int) -> void:
	_set_bar(npc, value)

func _set_bar(npc: String, value: int) -> void:
	for node in get_tree().get_nodes_in_group(npc):
		if node is Range and node.is_in_group("ProgressBar"):
			node.value = value
