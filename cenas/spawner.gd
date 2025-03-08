extends Node2D

const CENAS_MONSTROS = [
	preload("res://cenas/monstros/goblin.tscn"),
	preload("res://cenas/monstros/goblin_metal.tscn"),
	preload("res://cenas/monstros/goblin.tscn"),
	preload("res://cenas/monstros/goblin.tscn"),
	preload("res://cenas/monstros/goblin.tscn")
]

@export var inimigos : Node2D
@export var waves : Array[MonsterWave]

@onready var spawn_esquerda = $SpawnEsquerda
@onready var spawn_direita = $SpawnDireita

# um pra cada tipo de monstro
var timers = [0.0, 0.25, 0.5, 0.75, 1.0]
var monstros = [0, 0, 0, 0, 0]

var wave_atual : int = 1
var monstros_vivos : int = 0

func _ready():
	iniciar_wave()

func _process(delta):
	for i in monstros.size():
		if monstros[i] > 0:
			timers[i] -= delta
			if timers[i] < 0.0:
				monstros[i] -= 1
				timers[i] = waves[wave_atual-1].intervalo_spawn
				spawn_monstro(i)
	
	if monstros_vivos <= 0:
		proxima_wave()
		# TODO delay pequeno e texto na tela de "Wave 2"
		iniciar_wave()

func spawn_monstro(tipo):
	var novo_monstro = CENAS_MONSTROS[tipo].instantiate()
	inimigos.add_child(novo_monstro)
	var ponto_spawn = spawn_esquerda.global_position if randi() % 2 == 0 else spawn_direita.global_position
	novo_monstro.global_position = ponto_spawn
	novo_monstro.morreu.connect(monstro_morreu)

func iniciar_wave():
	if wave_atual - 1 < monstros.size():
		monstros[0] = waves[wave_atual-1].goblins
		monstros[1] = waves[wave_atual-1].goblins_metal
		monstros[2] = waves[wave_atual-1].lobisomens
		monstros[3] = waves[wave_atual-1].esqueletos
		monstros[4] = waves[wave_atual-1].morcegos
		monstros_vivos = monstros[0] + monstros[1] + monstros[2] + monstros[3] + monstros[4]

func proxima_wave():
	wave_atual = clamp(wave_atual + 1, 0, waves.size())

func monstro_morreu():
	monstros_vivos -= 1
