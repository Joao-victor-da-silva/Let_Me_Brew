extends Node2D

@export_range(0.0, 10.0, 0.01) var tempo_cooldown : float = 2.0

var timer_cooldown : float = 0.0

func _process(delta):
	timer_cooldown -= delta

func ativar():
	pass

func cooldown():
	timer_cooldown = tempo_cooldown

func pode_ativar():
	return timer_cooldown <= 0.0
