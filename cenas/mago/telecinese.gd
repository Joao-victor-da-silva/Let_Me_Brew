extends "res://cenas/mago/spell_base.gd"

@export var tempo_efeito : float = 5.0

var timer : float = 0.0
var held_body : Node2D

func _physics_process(delta):
	timer -= delta
	
	# Checar se soltou mouse
	if Input.is_action_just_released("left_click") or timer < 0.0:
		if held_body:
			soltar()
	
	# Checar se agarrou alguma mobília
	if timer > 0.0:
		for body in Globals.mobilias:
			if body.is_mouse_over():
				agarrar(body)
				break
	
	for body in Globals.mobilias:
		if body != held_body:
			body.gravity_scale = 1
	
	if held_body:
		var target_pos = get_global_mouse_position()
		var speed = 800.0 * held_body.global_position.distance_to(target_pos) * held_body.mass
		var dir = held_body.global_position.direction_to(target_pos)
		held_body.linear_velocity = Vector2.ZERO
		held_body.apply_central_force(dir * speed)
		held_body.gravity_scale = 0

func ativar():
	timer = tempo_efeito

func agarrar(body):
	held_body = body
	held_body.linear_velocity = Vector2.ZERO
	held_body.angular_velocity = 0.0
	held_body.freeze = false

func soltar():
	held_body.linear_velocity = Vector2.ZERO
	held_body = null
