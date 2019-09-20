extends "res://Assets/Scripts/Balls/Ball.gd"

#Signal emmited every time a player score a point
signal score

func _ready() -> void:
	#Set the timer to start to make the ball move
	RestartTimer.start(DataManager.waitSecs)

func _process(delta: float) -> void:
	if position.x < 0:
		#Give a point to player2
		DataManager.Player2Score += 1
		#Reset the ball for the next point
		reset()
	if position.x > screen_size.x:
		#Give a point to player1
		DataManager.Player1Score += 1
		#Reset the ball for the next point
		reset()

#Function called every time a player scores a point 
func reset() -> void:
		#Play sound
		ScoreSound.play()
		#Set position at the middle of the screen
		position = screen_size / 2
		#Set the timer
		RestartTimer.start(DataManager.waitSecs)
		#Stop the ball and reset Strength
		Strength = 1000
		stop()
		#Emit the signal
		emit_signal("score")
