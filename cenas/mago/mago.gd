extends Node2D

const TAMANHO_MAXIMO_ESCUDO = 70.0
const COR_ESCUDO_NORMAL = Color("0098db")
const COR_ESCUDO_DANIFICADO = Color("db3535")

@onready var escudo = $Escudo
@onready var sprite = $Sprite
@onready var barra_vida = $BarraVida

var escudo_ativo : bool = true
var tamanho_escudo : float = 70.0
var vida_atual : float = 200.0
var timer_flash : float = 0.0

func _ready():
	sprite.material.set_shader_parameter("flash_amount", 0.0)
	Globals.inimigo_atacou.connect(tomar_dano)

func _process(delta):
	# Atualizar cor do escudo
	timer_flash -= delta
	if escudo_ativo:
		var cor_escudo = COR_ESCUDO_DANIFICADO if timer_flash > 0.0 else COR_ESCUDO_NORMAL
		set_cor_escudo(cor_escudo)
	else:
		sprite.material.set_shader_parameter("flash_amount", 1.0 if timer_flash > 0.0 else 0.0)
	
	# Atualizar tamanho do escudo
	if escudo_ativo:
		tamanho_escudo = lerp(35.0, 70.0, (vida_atual - 100.0) / 100.0)
		escudo.scale = Vector2.ONE * 64.0 * tamanho_escudo / TAMANHO_MAXIMO_ESCUDO
	else:
		tamanho_escudo = 20.0
		escudo.visible = false
	
	# Atualizar barra de vida
	barra_vida.visible = not escudo_ativo
	barra_vida.value = vida_atual
	
	Globals.posicao_player = global_position
	Globals.tamanho_escudo = tamanho_escudo

func tomar_dano(dano):
	if vida_atual > 100.0:
		timer_flash = 0.2
		vida_atual = clamp(vida_atual - dano, 100.0, 200.0)
	else:
		if not escudo_ativo:
			timer_flash = 0.2
			vida_atual -= dano
		escudo_ativo = false
	
	if vida_atual <= 0:
		Globals.player_morreu.emit()

func set_cor_escudo(cor: Color):
	escudo.material.set_shader_parameter("shield_color", cor)
