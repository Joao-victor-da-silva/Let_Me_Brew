extends Node2D
	
func _input(event: InputEvent) -> void:
		if event.is_action_pressed("left_click"):
			$"../Caixa".freeze_mode = true
			$"../Caixa".freeze = true
			$"../Caixa".global_position = get_global_mouse_position()
			$"../Caixa".freeze = false
			$"../Caixa".freeze_mode = false
			$"../Caixa".gravity_scale = 1
			$"../Caixa".linear_velocity = Vector2.ZERO
			$"../Caixa".force_update_transform()
			$"../Caixa".controle_magia($"../Caixa".id_magia)
