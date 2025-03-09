extends RigidBody2D

@export var id_magia = 0
@onready var sprite = $Sprite2D
@onready var area_fogo = $fogo/areaMagia
@onready var chama = $fogo
@onready var chamas_particulas = $fogo/chama

func _ready() -> void:	
	controle_magia(id_magia)
	pass
	
func _process(delta: float) -> void:
	chamas_particulas.global_rotation = 0
	pass
	
func controle_magia(id_magia):
	match id_magia:
		0:
			normal()
		1:
			fogo()
		2:
			gelo()
		3: 
			telecinese()
	pass 

func normal():
	sprite.modulate = Color8(255,255,255,255)
	chama.visible = false
	set_collision_mask_value(8, false) 
	pass

func fogo():
	sprite.modulate = Color8(255,56,25,255)
	area_fogo.visible = true
	chama.visible = true
	set_collision_mask_value(8, true)
	#await Utils.timer(5.0)
	#sprite.visible = false
	#chamas_particulas.emitting = false
	#await Utils.timer(0.5)
	#queue_free()
	pass
	
func gelo():
	sprite.modulate = Color8(137,255,255,255)
	chama.visible = false
	set_collision_mask_value(8, true)
	pass

func telecinese():
	sprite.modulate = Color8(232,0,248,255)
	chama.visible = false
	set_collision_mask_value(8, true)
	pass

func _on_fogo_body_entered(body: Node2D) -> void:
	if id_magia == 1:
		body.controle_magia(id_magia)
	pass # Replace with function body.
