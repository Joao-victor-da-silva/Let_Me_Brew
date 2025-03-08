extends Node2D

const TAMANHO_MAXIMO_ESCUDO = 70.0
const COR_ESCUDO_NORMAL = Color("0098db")
const COR_ESCUDO_DANIFICADO = Color("db3535")

@onready var escudo = $Escudo

var tamanho_escudo : float = 70.0
var vida_atual : float = 200.0
var timer_flash : float = 0.0

func _ready():
	Globals.inimigo_atacou.connect(tomar_dano)

func _physics_process(delta):
	# Atualizar cor do escudo
	timer_flash -= delta
	if timer_flash > 0.0:
		set_cor_escudo(COR_ESCUDO_DANIFICADO)
	else:
		set_cor_escudo(COR_ESCUDO_NORMAL)
	
	# Atualizar tamanho do escudo
	if vida_atual > 100.0:
		tamanho_escudo = lerp(20.0, 70.0, (vida_atual - 100.0) / 100.0)
		escudo.scale = Vector2.ONE * 64.0 * tamanho_escudo / TAMANHO_MAXIMO_ESCUDO
	else:
		escudo.visible = false
	
	Globals.posicao_player = global_position
	Globals.tamanho_escudo = tamanho_escudo

func tomar_dano(dano):
	timer_flash = 0.2
	if vida_atual > 100.0:
		vida_atual = clamp(vida_atual - dano, 100.0, 200.0)
	else:
		vida_atual -= dano

func set_cor_escudo(cor: Color):
	escudo.material.set_shader_parameter("shield_color", cor)
