extends "res://Assets/Scripts/Player/Pad.gd"

var BallPos : Vector2
var BallDir : Vector2
var NewPosition : float
var margin : int = 50 
# Easy -> margin = 150
# Normal -> margin = 120
var CanMove : bool = false

func _process(delta: float) -> void:
	BallPos = DataManager.BallPos
	BallDir = DataManager.BallDir
	
	#Only move if the ball is in its half of the screen and in the rigth half of the screen
	CanMove = BallDir.x > 0 #BallPos.x > screen_size.x / 2
	
	if CanMove:
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
	