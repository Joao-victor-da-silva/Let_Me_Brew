extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	Transitions.fade_from_black(0.25)
	Globals.player_morreu.connect(game_over)

func game_over():
	get_tree().paused = true
	animation_player.play("game_over")

func jogar_novamente():
	get_tree().paused = false
	get_tree().reload_current_scene()

func menu_principal():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/tela_titulo.tscn")
