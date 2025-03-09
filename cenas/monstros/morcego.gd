extends "res://cenas/monstros/monstro.gd"

const CENA_PROJETIL = preload("res://cenas/monstros/projetil.tscn")

func _physics_process(delta):
	if timer_ataque.is_stopped() && parado == false:
		var distancia_player = Globals.posicao_player.distance_to(global_position)
		if distancia_player > 100.0:
			var direcao_player = global_position.direction_to(Globals.posicao_player)
			velocity = speed * direcao_player
			move_and_collide(velocity * delta)
		else:
			timer_ataque.start()
			animation_player.play("ataque")

func ataque():
	var direcao_player = global_position.direction_to(Globals.posicao_player)
	var projetil = CENA_PROJETIL.instantiate()
	add_child(projetil)
	projetil.global_position = global_position
	projetil.atirar(direcao_player)
