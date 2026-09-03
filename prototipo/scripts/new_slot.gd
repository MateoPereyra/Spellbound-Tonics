class_name Slot extends PanelContainer

signal toggle_label(data: ItemData, flag: bool)

enum SlotType { NORMAL, INGREDIENTE, RESULTADO }

@export var slot_type : SlotType = SlotType.NORMAL
@onready var texture_rect: TextureRect = $TextureRect

@export var item : ItemData = null:
	set(value):
		item = value
		
		if value != null:
			var temp_instance = value.scene.instantiate()
			$TextureRect.texture = temp_instance.get_node("Sprite2D").texture
			temp_instance.queue_free()
		else:
			$TextureRect.texture = null
		
		if slot_type == SlotType.INGREDIENTE:
			toggle_label.emit(value, value != null)

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
	return data is Slot

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var temp = item
	item = data.item
	data.item = temp
	
