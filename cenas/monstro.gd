extends CharacterBody2D

const gravity = 300.0
const speed = 40.0
const dano = 5

@onready var sprite = $Sprite
@onready var timer_ataque = $TimerAtaque
@onready var animation_player = $AnimationPlayer

func _process(delta):
	# Animações
	if abs(velocity.x) > 0.0:
		sprite.scale.x = sign(velocity.x)
	
	if timer_ataque.is_stopped():
		sprite.play("andando")

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
