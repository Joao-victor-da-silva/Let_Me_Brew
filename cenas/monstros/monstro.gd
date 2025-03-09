extends CharacterBody2D

signal morreu

const gravity = 300.0

@export var speed = 40.0
@export var vida_maxima = 20
@export var dano = 5

@onready var sprite = $Sprite
@onready var timer_ataque = $TimerAtaque
@onready var animation_player = $AnimationPlayer
@onready var gelo_part = $gelo
@onready var fogo_part = $chama 
@onready var vida_atual = vida_maxima

@onready var parado = false
@onready var seguir = false
@onready var caixa

func _process(delta):
	# Animações
	if abs(velocity.x) > 0.0:
		sprite.scale.x = sign(velocity.x)
	if timer_ataque.is_stopped() && parado == false:
		sprite.play("andando")
	fogo_part.global_rotation = 0
	if seguir == true:
		seguindo()
	if caixa != null:
		if caixa.id_magia == 0:
			controle_magia(0)
pass

func seguindo():
	#freeze = true
	global_position = get_global_mouse_position()
	#freeze = false
	#freeze_mode = false
	#gravity_scale = 1
	#linear_velocity = Vector2.ZERO
	force_update_transform()
	#controle_magia($"../Caixa".id_magia)
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
	seguir = false
	parado = false
	caixa = null
	pass

func fogo():
	queimando()
	pass

func gelo():
	parado = true
	sprite.modulate = Color8(137,255,255,255)
	sprite.pause()
	set_collision_mask_value(4, true)
	gelo_part.visible = true
	await Utils.timer(5.0)
	gelo_part.visible = false
	set_collision_mask_value(4, false)
	sprite.modulate = Color8(255,255,255,255)
	sprite.play()
	parado = false
	pass
	
func telecinese():
	sprite.modulate = Color8(0,255,0,255)
	seguir = true
	parado = true
	await Utils.timer(5.0)
	controle_magia(0)
	pass
	
func _physics_process(delta):
	if timer_ataque.is_stopped() && parado == false:
		var distancia_player = abs(Globals.posicao_player.x - global_position.x)
		if distancia_player > Globals.tamanho_escudo:
			var direcao_player = sign(Globals.posicao_player.x - global_position.x)
			velocity.x = speed * direcao_player
			velocity.y += gravity * delta
			move_and_slide()
		else:
			timer_ataque.start()
			animation_player.play("ataque")

func ataque():
	Globals.inimigo_atacou.emit(dano)

func tomar_dano(dano):
	vida_atual -= dano
	if vida_atual <= 0.0:
		morreu.emit()
		queue_free() # TODO animação de morte melhor

func _on_hitbox_area_entered(area):
	if area.is_in_group("fogo"):
		queimando()
		tomar_dano(area.get_parent().dano)

func queimando():
	fogo_part.visible = true
	sprite.modulate = Color8(255,56,25,255)
	await Utils.timer(2.0)
	sprite.visible = false
	fogo_part.emitting = false
	await Utils.timer(0.5)
	tomar_dano(30)
	pass
