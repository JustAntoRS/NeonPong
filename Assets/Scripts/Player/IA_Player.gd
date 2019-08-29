extends "res://Assets/Scripts/Player/Pad.gd"

var BallPos : Vector2
var BallDir : Vector2
var NewPosition : float
var margin : int = 120
# Easy mode -> margin = 150

func _process(delta: float) -> void:
	BallPos = DataManager.BallPos
	BallDir = DataManager.BallDir
	
	#Only move if the ball is in its half of the screen and moving to the pad
	if BallPos.x > screen_size.x / 2 and BallDir.x > 0 :
		move()
	
func move() -> void:
	NewPosition = position.y
	
	if BallPos.y > position.y + margin:
		NewPosition += Speed
	elif BallPos.y < position.y - margin:
		NewPosition -= Speed
	
	position.y = NewPosition

func _on_2PlayersBall_score() -> void:
	position = initial_pos
	