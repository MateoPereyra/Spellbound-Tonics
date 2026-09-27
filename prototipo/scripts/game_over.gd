extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true

func _on_button_pressed() -> void:
	get_tree().paused = false
	GameData.restart_day_count()
	GameData.restart_saved_money()
	get_tree().reload_current_scene()


func _on_button_2_pressed() -> void:
	get_tree().quit()
