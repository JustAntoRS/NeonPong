extends "res://Assets/Scripts/Player/Pad.gd"

"""
Script that defines a generic implementation of a player controlled
by the computer    
"""

var BallPos : Vector2
var BallDir : Vector2
var NewPosition : float
var margin : int = 50 
# Easy -> margin = 150
# Normal -> margin = 120

func _process(delta: float) -> void:
	BallPos = DataManager.BallPos
	BallDir = DataManager.BallDir
	
func move() -> void:
	NewPosition = position.y
	
	if BallPos.y > position.y + margin:
		NewPosition += Speed
	elif BallPos.y < position.y - margin:
		NewPosition -= Speed
	
	position.y = NewPosition

func _on_2PlayersBall_score() -> void:
	position = initial_pos

