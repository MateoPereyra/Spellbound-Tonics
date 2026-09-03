extends CharacterBody2D

@onready var motion := Vector2.ZERO
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var money_label: Label = $CanvasLayer/MoneyLabel
@onready var spell_icon: TextureRect = $CanvasLayer/SpellIcon
@onready var current_spell_label: Label = $CanvasLayer/CurrentSpellLabel

@export var health := 100
@export var speed := 100
@export var pick_speed := 90
@export var available_spells : Array[PackedScene] = []
@export var money := 100

var objeto_a_agarrar : Array[StaticBody2D] = []
var inventory_full := false
var current_spell
var is_interacting := false

signal picked(item_data: ItemData)

func _ready() -> void:
	current_spell = available_spells[0]
	health_bar.value = health
	money_label.text = "$" + str(money)
	spell_icon.texture = get_spell_texture(current_spell)
	get_current_spell(current_spell)

func _input(event: InputEvent) -> void:
	if not is_interacting:
		motion = Input.get_vector("left", "right", "up", "down")
		if event.is_action_pressed("spell"):
			use_spell()

func _physics_process(delta: float) -> void:
	velocity = speed * motion
	if not is_interacting:
		move_and_slide()
	
	if inventory_full == false:
		for a in objeto_a_agarrar:
			a.global_position = a.global_position.move_toward(self.global_position, pick_speed * delta)
			if a.global_position.distance_to(self.global_position) < 5.0:
				pick_item(a, objeto_a_agarrar)

func pick_item(item: StaticBody2D, array: Array[StaticBody2D]):
	var data := ItemData.new()
	data.scene = load(item.scene_file_path)
	data.efecto = item.efecto
	data.name = item.name
	picked.emit(data)
	array.erase(item)
	item.queue_free()

func _on_pick_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Pickable") and body not in objeto_a_agarrar:
		objeto_a_agarrar.push_back(body)

func _on_inventory_inventory_filled() -> void:
	inventory_full = true

func use_spell():
	var shot = current_spell.instantiate()
	get_parent().add_child(shot)
	shot.global_position = $Marker2D.global_position
	shot.direction = (get_global_mouse_position() - shot.global_position).normalized()

func toggle_interact():
	is_interacting = !is_interacting

func get_spell_texture(spell_scene: PackedScene) -> Texture2D:
	if spell_scene == null:
		return null
	
	var temp_instance = spell_scene.instantiate()
	var texture = temp_instance.get_node("Sprite2D").texture
	temp_instance.queue_free()
	
	return texture

func get_current_spell(spell_scene: PackedScene):
	if spell_scene == null:
		return null
	
	var temp_instance = spell_scene.instantiate()
	current_spell_label.text = "Current spell: " + temp_instance.name
	temp_instance.queue_free()

func take_damage(damage: int):
	health -= damage
	health_bar.value = health
	if health <= 0:
		prints("0 HP")
	pass

func potion_bought(amount: int):
	money += amount
	money_label.text = str(money)
