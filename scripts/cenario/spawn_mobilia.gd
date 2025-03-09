extends Node2D

@export var lista_mobilia: Array[RigidBody2D]
@onready var ponto_spawn: Array[Node2D] = [$spawn_mobilia01, $spawn_mobilia02,$spawn_mobilia03, $spawn_mobilia04]
@onready var caixa = "res://prefabs/caixa.tscn"
@onready var cadeira = "res://prefabs/cadeira.tscn"
@onready var mesa = "res://prefabs/mesa.tscn"
@onready var placa = "res://prefabs/placa.tscn"
@onready var caminhos: Array[String] = [caixa,cadeira,mesa,placa] 

func _process(delta: float) -> void:
	if lista_mobilia.size() < 4:
		spawn()
	#for y in lista_mobilia.size() - 1:
	#	if is_instance_valid(lista_mobilia[y]) == false:
	#		lista_mobilia.remove_at(y)
	pass
	
func spawn():
	for i in 4:
		print(i)
		var sorteado = randi_range(0,3)
		var prefab = load(caminhos[sorteado])
		var mobilia_instaciada = prefab.instantiate()
		add_child(mobilia_instaciada)
		lista_mobilia.append(mobilia_instaciada)
		lista_mobilia[i].global_position = ponto_spawn[i].global_position
		lista_mobilia[i].controle_magia(0)
	pass 
