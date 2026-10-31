extends Control

@export_file("*.tscn") var boton_jugar: String
@export_file("*.tscn") var boton_controles: String

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file(boton_jugar)

func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file(boton_controles)

func _on_salir_pressed() -> void:
	get_tree().quit()
