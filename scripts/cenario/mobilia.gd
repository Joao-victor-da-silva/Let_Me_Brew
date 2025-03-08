extends RigidBody2D
@export var id_magia = 0

#apredendo loop
func _ready() -> void:	
	var efeito = false
	controle_magia(id_magia)
	pass
	
func controle_magia(id_magia):
	match id_magia:
		0:
			print("normal")
			set_collision_mask_value(8, false) 
		1:
			print("fogo")
			set_collision_mask_value(8, true)
		2:
			print("gelo")
			set_collision_mask_value(8, true)
		3: 
			print("telecinese")
			set_collision_mask_value(8, true)
	pass 
