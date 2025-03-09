extends Node2D

func _on_jogar_pressed():
	Transitions.fade_to_black(0.25)
	await Utils.timer(0.25)
	get_tree().change_scene_to_file("res://cenas/jogo.tscn")

func _on_sair_pressed():
	get_tree().quit()
