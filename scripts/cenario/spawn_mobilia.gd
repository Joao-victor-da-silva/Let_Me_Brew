extends Node2D

@onready var ponto_spawn: Array[Node2D] = [$spawn_mobilia01, $spawn_mobilia02,$spawn_mobilia03, $spawn_mobilia04]
@onready var caixa = "res://prefabs/caixa.tscn"
@onready var cadeira = "res://prefabs/cadeira.tscn"
@onready var mesa = "res://prefabs/mesa.tscn"
@onready var placa = "res://prefabs/placa.tscn"
@onready var caminhos: Array[String] = [caixa,cadeira,mesa,placa] 
@onready var i = 0

func _ready() -> void:
	spawn(0)
	spawn(1)
	spawn(2)
	spawn(3)
	pass

func _process(delta: float) -> void:
	#if Globals.mobilias.size() < 4:
		#spawn()
	pass
	
func spawn(id):
	var sorteado = randi_range(0,3)
	var prefab = load(caminhos[sorteado])
	var mobilia_instaciada = prefab.instantiate()
	add_child.call_deferred(mobilia_instaciada)
	mobilia_instaciada.destroida.connect(spawn)
	print(id)
	mobilia_instaciada.global_position = ponto_spawn[id].global_position
	pass 
