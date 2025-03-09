extends Node2D

enum SPELLS { FOGO, GELO, TELECINESE }

@onready var spells = {
	SPELLS.FOGO: $Fogo,
	SPELLS.GELO: $Gelo,
	SPELLS.TELECINESE: $Telecinese
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
	# Checar se ativou spell selecionada
	if Input.is_action_just_pressed("left_click"):
		var spell = spells[spell_selecionada]
		if spell.pode_ativar():
			spell.ativar()
