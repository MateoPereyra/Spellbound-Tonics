extends CanvasModulate

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var day_label: Label = $CanvasLayer/DayLabel

signal new_day

#var night := false
var day_to_night := true  # true mientras la animación va de día a noche

func _ready() -> void:
	new_day.connect(GameData.on_new_day)
	update_label()
	#day_label.text = "Día " + str(GameData.current_day) + ". En " + str(GameData.rent_day) + " días se debe pagar " + str(GameData.rent)

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	#if !night:
		#new_day.emit()
		#animation_player.play_backwards("ciclo")
	#else:
		#animation_player.play("ciclo")
	#night = !night
	#day_label.text = "Día " + str(GameData.current_day) + ". En " + str(GameData.rent_day) + " días se debe pagar " + str(GameData.rent)
	if day_to_night:
		#Acaba de hacerse de noche
		new_day.emit()
		animation_player.play_backwards("ciclo")
	else:
		#Acaba de amanecer
		animation_player.play("ciclo")
	day_to_night = not day_to_night
	update_label()

func update_label() -> void:
	var texto := "Día " + str(GameData.current_day) + ". "
	if GameData.is_rent_day():
		texto += "Esta noche hay que pagar $" + str(GameData.rent)
	else:
		var d : int = GameData.days_until_rent()
		texto += "En " + str(d) + (" día" if d == 1 else " días") + " se debe pagar $" + str(GameData.rent)
	day_label.text = texto
