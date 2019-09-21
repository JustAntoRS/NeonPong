extends "res://Assets/Scripts/Player/Pad.gd"

"""
Script that defines a generic implementation of a player controlled
by the computer    
"""
#Variables
var BallPos : Vector2
var BallDir : Vector2
var margin : int


func _ready() -> void:
	
	#Set difficulty
	if DataManager.Difficulty == "easy":
		margin = 40 + player_size.y / 2
	elif DataManager.Difficulty == "normal":
		margin = 30 + player_size.y / 2
	elif DataManager.Difficulty == "hard":
		margin = 20 + player_size.y / 2
	else: #god difficulty for background
		margin = 40

func _process(delta: float) -> void:
	#Synchronize the position and movement vector
	BallPos = DataManager.BallPos
	BallDir = DataManager.BallDir

	if position.x < screen_size.x / 2 and BallDir.x < 0:  #AI is player 1
		move()
	elif position.x > screen_size.x / 2 and BallDir.x >0: #AI is player 2
		move()

"""
Function that moves the pad depending of the position and movement vector
of the ball

This is a basic and not very good implementation
"""
func move() -> void:
	if BallPos.y < position.y - player_size.y / 4 and BallPos.y > position.y + player_size.y / 4:
		pass
	else:
		if BallPos.y < position.y - margin:
			position.y -= Speed
		elif BallPos.y > position.y + margin:
			position.y += Speed
	


#Function that resets de pad position every point 
func _on_2PlayersBall_score() -> void:
	position = initial_pos

