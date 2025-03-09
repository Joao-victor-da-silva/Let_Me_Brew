extends RigidBody2D

@export var id_magia = 0

@onready var collision_shape = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var area_fogo = $fogo/areaMagia
@onready var chama = $fogo
@onready var chamas_particulas = $fogo/chama
@onready var gelo_part = $gelo
var caixa

var index = 0 
signal destroida(index)

func _ready() -> void:
	controle_magia(id_magia)

func _process(delta: float) -> void:
	chamas_particulas.global_rotation = 0

func controle_magia(id_magia_paremetro):
	id_magia = id_magia_paremetro
	match id_magia:
		0:
			normal()
		1:
			fogo()
		2:
			gelo()
		3: 
			telecinese()

func normal():
	id_magia = 0
	sprite.modulate = Color8(255,255,255,255)
	chama.visible = false
	set_collision_layer_value(8, false)
	set_collision_mask_value(8, false)
	set_collision_mask_value(4, false)
	set_collision_layer_value(3, true)

func fogo():
	id_magia = 1
	sprite.modulate = Color8(255,56,25,255)
	area_fogo.visible = true
	chama.visible = true
	set_collision_mask_value(4, true)
	await Utils.timer(5.0)
	sprite.visible = false
	chamas_particulas.emitting = false
	await Utils.timer(0.5)
	queue_free()

func gelo():
	id_magia = 2
	sprite.modulate = Color8(137,255,255,255)
	chama.visible = false
	set_collision_layer_value(8, true)
	set_collision_layer_value(3, false)
	set_collision_mask_value(8, true)
	set_collision_mask_value(4, true)
	gelo_part.visible = true
	await Utils.timer(5.0)
	gelo_part.visible = false
	controle_magia(0)

func telecinese():
	id_magia = 3
	sprite.modulate = Color8(0,255,0,255)
	chama.visible = false
	set_collision_mask_value(4, true)

func _on_fogo_body_entered(body: Node2D) -> void:
	if id_magia == 1 || id_magia == 3 :
		body.controle_magia(id_magia)
		if id_magia == 3:
			body.caixa = self

func _enter_tree():
	Globals.mobilias.append(self)
	index = Globals.mobilias.size() - 1

func _exit_tree():
	destroida.emit(index)
	Globals.mobilias.remove_at(Globals.mobilias.find(self))

func is_mouse_over():
	var mouse = get_global_mouse_position()
	
	if collision_shape.shape is RectangleShape2D:
		var rect = collision_shape.shape.get_rect()
		rect.position += collision_shape.global_position
		rect.size += Vector2(4, 4)
		return rect.has_point(mouse)
	
	if collision_shape.shape is CircleShape2D:
		var distance = collision_shape.global_position.distance_to(mouse) - 2.0
		return distance <= collision_shape.shape.radius
