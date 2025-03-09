extends "res://cenas/mago/spell_base.gd"

@export var dano : int = 30

@onready var trigger_fogo = $TriggerFogo
@onready var collision_shape = $TriggerFogo/CollisionShape2D

func _ready():
	collision_shape.set_deferred("disabled", true)

func _physics_process(delta):
	var mouse = get_global_mouse_position()
	trigger_fogo.global_position = mouse

func ativar():
	collision_shape.set_deferred("disabled", false)
	await Utils.timer(0.1)
	collision_shape.set_deferred("disabled", true)
	cooldown()

func _on_trigger_fogo_body_entered(body: Node2D) -> void:
	body.controle_magia(1)
	pass 
