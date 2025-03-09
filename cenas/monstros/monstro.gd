extends CharacterBody2D

signal morreu

const gravity = 300.0

@export var speed = 40.0
@export var vida_maxima = 20
@export var dano = 5

@onready var sprite = $Sprite
@onready var timer_ataque = $TimerAtaque
@onready var animation_player = $AnimationPlayer

@onready var vida_atual = vida_maxima

func _process(delta):
	# Animações
	if abs(velocity.x) > 0.0:
		sprite.scale.x = sign(velocity.x)
	
	if timer_ataque.is_stopped():
		sprite.play("andando")
pass

func controle_magia(id_magia):
	match id_magia:
		0:
			normal()
			speed = 40.0
		1:
			fogo()
		2:
			gelo()
			speed = 0.0
		3: 
			telecinese()	
	pass

func normal():
	pass

func fogo():
	pass

func gelo():
	
	pass
	
func telecinese():
	pass
	
func _physics_process(delta):
	if timer_ataque.is_stopped():
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
		tomar_dano(area.get_parent().dano)
