extends StaticBody2D

var can_interact := false
var ui_visible := false
var player_ref

func _ready() -> void:
	$CanvasLayer/PotionMakingUI.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		player_ref.toggle_interact()
		if ui_visible == false:
			$CanvasLayer/PotionMakingUI.show()
			ui_visible = true
		else:
			$CanvasLayer/PotionMakingUI.hide()
			ui_visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
		player_ref = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false
		player_ref = null
