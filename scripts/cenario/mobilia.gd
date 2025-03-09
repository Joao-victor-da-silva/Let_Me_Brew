extends RigidBody2D

@export var id_magia = 2

@onready var collision_shape = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var area_fogo = $fogo/areaMagia
@onready var chama = $fogo
@onready var chamas_particulas = $fogo/chama
var index = 0 
signal destroida(index)

func _ready() -> void:
	controle_magia(id_magia)

func _process(delta: float) -> void:
	chamas_particulas.global_rotation = 0

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

func normal():
	sprite.modulate = Color8(255,255,255,255)
	chama.visible = false
	set_collision_mask_value(4, false)

func fogo():
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
	sprite.modulate = Color8(137,255,255,255)
	chama.visible = false
	set_collision_mask_value(4, true)
	await Utils.timer(5.0)
	controle_magia(0)

func telecinese():
	sprite.modulate = Color8(232,0,248,255)
	chama.visible = false
	set_collision_mask_value(4, true)

func _on_fogo_body_entered(body: Node2D) -> void:
	if id_magia == 1:
		body.controle_magia(id_magia)

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
