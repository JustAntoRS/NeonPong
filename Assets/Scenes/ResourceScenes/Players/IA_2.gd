extends "res://Assets/Scripts/Player/IA_Player.gd"

func _process(delta: float) -> void:
	
	if BallDir.x > 0:
		move()