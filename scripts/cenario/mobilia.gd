extends RigidBody2D
@export var id_magia = 0

#apredendo loop
func _ready() -> void:	
	var efeito = false
	controle_magia(id_magia)
	pass
	
func _process(delta: float) -> void:
	$fogo/fogo.global_rotation = 0
	pass
	
func controle_magia(id_magia):
	match id_magia:
		0:
			print("normal")
			$Sprite2D.modulate = Color8(255,255,255,255)
			$fogo.visible = false
			set_collision_mask_value(8, false) 
		1:
			print("fogo")
			$Sprite2D.modulate = Color8(255,56,25,255)
			$fogo/areaMagia.visible = true
			$fogo.visible = true
			set_collision_mask_value(8, true)
		2:
			print("gelo")
			$Sprite2D.modulate = Color8(137,255,255,255)
			$fogo.visible = false
			set_collision_mask_value(8, true)
		3: 
			print("telecinese")
			$Sprite2D.modulate = Color8(232,0,248,255)
			$fogo.visible = false
			set_collision_mask_value(8, true)
	pass 


func _on_fogo_body_entered(body: Node2D) -> void:
	if id_magia == 1:
		body.controle_magia(id_magia)
	pass # Replace with function body.
