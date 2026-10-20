class_name WorldItem extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D

var item : ItemInstance :
	set(value):
		item = value
		_refresh()

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if sprite == null or item == null:
		return
	sprite.texture = item.definition.icon
