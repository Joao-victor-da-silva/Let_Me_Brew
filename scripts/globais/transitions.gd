extends CanvasLayer

@onready var black = $Black

func fade_to_black(duration: float):
	black.modulate = Color.TRANSPARENT
	var tween = create_tween()
	tween.tween_property(black, "modulate", Color.WHITE, duration)
	tween.play()

func fade_from_black(duration: float):
	black.modulate = Color.WHITE
	var tween = create_tween()
	tween.tween_property(black, "modulate", Color.TRANSPARENT, duration)
	tween.play()
