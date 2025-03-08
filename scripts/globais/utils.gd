extends Node

func timer(delay: float):
	return get_tree().create_timer(delay).timeout
