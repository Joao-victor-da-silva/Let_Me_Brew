extends CanvasLayer

const BORDA_COMUM = preload("res://assets/sprites/icone-borda.png")
const BORDA_MAIOR = preload("res://assets/sprites/icone-borda2.png")

@onready var buttons = $Buttons
@onready var bordas = $Bordas

func update_hud(spell_selecionada):
	for borda in bordas.get_children():
		borda.texture = BORDA_COMUM
	bordas.get_child(spell_selecionada).texture = BORDA_MAIOR

func update_cooldown(spell: int, threshold: float):
	var button = buttons.get_child(spell)
	var borda = bordas.get_child(spell)
	button.material.set_shader_parameter("threshold", threshold)
	if threshold < 1.0:
		borda.modulate = Color("808080")
	else:
		borda.modulate = Color.WHITE
