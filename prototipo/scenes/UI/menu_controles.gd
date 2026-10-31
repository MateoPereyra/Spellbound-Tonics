extends Control

const MENU_PRINCIPAL = preload("res://scenes/UI/menu_principal.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(MENU_PRINCIPAL)
