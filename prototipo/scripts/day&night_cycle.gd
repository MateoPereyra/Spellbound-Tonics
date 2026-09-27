extends CanvasModulate

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var day_label: Label = $CanvasLayer/DayLabel

signal new_day

var night := false

func _ready() -> void:
	new_day.connect(GameData.on_new_day)
	day_label.text = "Día " + str(GameData.current_day) + ". En " + str(GameData.rent_day) + " días se debe pagar " + str(GameData.rent)

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if !night:
		new_day.emit()
		animation_player.play_backwards("ciclo")
	else:
		animation_player.play("ciclo")
	night = !night
	day_label.text = "Día " + str(GameData.current_day) + ". En " + str(GameData.rent_day) + " días se debe pagar " + str(GameData.rent)
