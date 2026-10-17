class_name Slot extends PanelContainer

signal toggle_label(item: ItemInstance, flag: bool)

enum SlotType { NORMAL, INGREDIENTE, RESULTADO }

@export var slot_type : SlotType = SlotType.NORMAL
@onready var texture_rect: TextureRect = $TextureRect

@export var item : ItemInstance = null:
	set(value):
		item = value
		_refresh()
		if slot_type == SlotType.NORMAL or slot_type == SlotType.RESULTADO:
			toggle_label.emit(value, value != null)

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if texture_rect == null:
		return
	if item != null:
		texture_rect.texture = item.definition.icon
	else:
		texture_rect.texture = null

func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	return preview

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(get_preview())
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if slot_type == SlotType.RESULTADO:
		return false
	if not data is Slot:
		return false
	if slot_type == SlotType.INGREDIENTE and data.item != null and not data.item.definition.is_ingredient:
		return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var temp = item
	item = data.item
	data.item = temp
