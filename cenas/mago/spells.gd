extends Node2D

enum SPELLS { FOGO, GELO, TELECINESE }

@export var hud : CanvasLayer

@onready var fogo = $Fogo
@onready var gelo = $Gelo
@onready var telecinese = $Telecinese
@onready var spells = {
	SPELLS.FOGO: fogo,
	SPELLS.GELO: gelo,
	SPELLS.TELECINESE: telecinese
}

var spell_selecionada : SPELLS = SPELLS.FOGO

func _unhandled_input(event):
	# Checar se ativou spell selecionada
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var spell = spells[spell_selecionada]
			if spell.pode_ativar():
				spell.ativar()

func _process(delta):
	# Atualizar HUD
	hud.update_cooldown(0, fogo.get_cooldown())
	hud.update_cooldown(1, gelo.get_cooldown())
	hud.update_cooldown(2, telecinese.get_cooldown())

func _on_fogo_pressed():
	spell_selecionada = SPELLS.FOGO
	hud.update_hud(spell_selecionada)

func _on_gelo_pressed():
	spell_selecionada = SPELLS.GELO
	hud.update_hud(spell_selecionada)

func _on_telecinese_pressed():
	spell_selecionada = SPELLS.TELECINESE
	hud.update_hud(spell_selecionada)
