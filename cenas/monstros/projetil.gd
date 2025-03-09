extends Node2D

@export var speed : float = 50.0
@export var dano : float = 20.0

var move_direction : Vector2
var velocity : Vector2

func _physics_process(delta):
	velocity = speed * move_direction
	global_position += velocity * delta
	rotation = move_direction.angle() - PI/2
	if global_position.distance_to(Globals.posicao_player) < Globals.tamanho_escudo:
		destruir()

func atirar(direcao: Vector2):
	move_direction = direcao

func destruir():
	Globals.inimigo_atacou.emit(dano)
	queue_free()
