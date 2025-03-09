extends "res://cenas/mago/spell_base.gd"

@onready var colison = $TriggerGelo/CollisionShape2D
@onready var trigger_gelo = $TriggerGelo

func ativar():
	colison.set_deferred("disabled", 0)
	var mouse = get_global_mouse_position()
	trigger_gelo.global_position = mouse
	await Utils.timer(0.1)
	colison.set_deferred("disabled", 1)
	cooldown()

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.controle_magia(2)
	pass # Replace with function body.
