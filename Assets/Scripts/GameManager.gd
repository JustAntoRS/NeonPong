extends Node2D

"""
Node that controls the flow of the game with functions that check 
if the a player has won or the game is over... 
"""
#Signals
signal game_over
signal pause

#Nodes
onready var PauseTimer : Timer = $Timer
onready var GUI : MarginContainer = $"../GUI_2Players"
onready var Transition : Node2D = $"../Transition_In"

#Variables
var maxPoints : int


func _ready() -> void:
	#Start the timer so the pause cannot be activated at the start of the game
	PauseTimer.start(DataManager.waitSecs)
	#Reset basic data
	DataManager.Player1Score = 0
	DataManager.Player2Score = 0
	# Make sure that is immpossible to win in the background scene (crash if it happens)
	if DataManager.Difficulty == "god":
		maxPoints = 99999
	else:
		maxPoints = DataManager.MaxPoints
	
func _process(delta: float) -> void:
	if  PauseTimer.is_stopped() and Input.is_action_just_pressed("Pause") and !GUI.RestartTimeOn:
		#Emit the signal so other scripts react to the event
		emit_signal("pause")
		if get_tree().paused: #Check if the game is already paused
			PauseTimer.start(DataManager.waitSecs)
			return
		get_tree().paused = true

#Function that checks every time a player score a point if the player has won
func _on_2PlayersBall_score() -> void:
	if DataManager.Player1Score == maxPoints or DataManager.Player2Score == maxPoints :
		#Set the winner to player 2
		DataManager.Winner = 2
		#Check if the winner is the player 1 and if it is, change it
		if DataManager.Player1Score == DataManager.MaxPoints:
			DataManager.Winner = 1
		#Set difficulty to god again for the background 
		DataManager.Difficulty = "god"
		#Load GameOver Scene
		DataManager.sceneToLoad = "res://Assets/Scenes/MainScenes/GameOver_Menu.tscn"
		Transition.start_grow()

#Function call every time the child Timer node reaches 0
func _on_Timer_timeout() -> void:
	get_tree().paused = false
	PauseTimer.stop()

