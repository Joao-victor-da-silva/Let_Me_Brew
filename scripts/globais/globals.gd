extends Node

signal inimigo_atacou(dano)
signal player_morreu()

var posicao_player : Vector2
var tamanho_escudo : float
var mobilias = []

func _exit_tree():
	mobilias.clear()
