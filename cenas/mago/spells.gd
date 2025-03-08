extends Node2D

enum SPELLS { FOGO, GELO, TELECINESE }

@onready var spells = {
	SPELLS.FOGO: $Fogo,
	SPELLS.GELO: $Gelo,
	SPELLS.TELECINESE: $Telecinese
}

var cooldowns = {
	SPELLS.FOGO: 0.0,
	SPELLS.GELO: 0.0,
	SPELLS.TELECINESE: 0.0
}

var spell_selecionada : SPELLS = SPELLS.FOGO

func _input(event):
	# Lógica temporária pra trocar spells TODO trocar depois
	if event is InputEventKey:
		if event.keycode == KEY_1:
			spell_selecionada = SPELLS.FOGO
		if event.keycode == KEY_2:
			spell_selecionada = SPELLS.GELO
		if event.keycode == KEY_3:
			spell_selecionada = SPELLS.TELECINESE

func _process(delta):
	# Gerenciar cooldowns
	for key in cooldowns.keys():
		cooldowns[key] -= delta
	
	# Checar se ativou spell selecionada
	if Input.is_action_just_pressed("left_click"):
		if cooldowns[spell_selecionada] < 0.0:
			var node_spell = spells[spell_selecionada]
			node_spell.ativar()
			cooldowns[spell_selecionada] = node_spell.cooldown
