extends MarginContainer

#Nodes
onready var VanishAnimations : AnimationPlayer = $VanishAnimations
onready var Player1_ScoreText : Label = $Vertical/ScoreText/Player1
onready var Player2_ScoreText : Label = $Vertical/ScoreText/Player2
onready var PauseMenu : Container = $Vertical/PauseContainer
onready var RestartTimer : Timer = $Vertical/TimerContainer/Timer
onready var RestartLabel : Label = $Vertical/TimerContainer/Text

#variables
var waitSecs : int = DataManager.waitSecs
var RestartTimeOn : bool = true  #True when the timer of animation are playing

func _ready() -> void:
	RestartTimer.start(waitSecs)
	

func _process(delta: float) -> void:
	#Checks if the timer is playing
	if !RestartTimer.is_stopped():
		#Update the label text with the timer time left
		RestartLabel.text = ceil(RestartTimer.time_left) as String

#This function is called every time the signal "score" is emitted 
func _on_2PlayersBall_score() -> void:
	#Update Score Text
	Player1_ScoreText.text = DataManager.Player1Score as String
	Player2_ScoreText.text = DataManager.Player2Score as String
	#Start the timer
	RestartTimeOn = true
	RestartTimer.start(waitSecs)
	
#Function called when the internal timer of TimerContainer reaches 0
func _on_RestartTimer_timeout() -> void:
	RestartLabel.text = "0"
	VanishAnimations.play("VanishTimer")
	RestartTimer.stop()
	
#Function called every time the player pause the game 
func _on_GameManager_pause() -> void:
	PauseMenu.visible = !PauseMenu.visible
	
	if !PauseMenu.visible:
		RestartTimer.start(waitSecs)
	

#Function called every time an animation finish
func _on_VanishAnimations_animation_finished(anim_name: String) -> void:
	RestartTimeOn = false
	#Set the Timer Label Color back to the default one since the vanish animation change the alpha coord
	RestartLabel.text = ""
	RestartLabel.modulate = Color(1,1,1,1)



func _on_ExitButton_pressed() -> void:
	#Temporal, must think about saving high-scores
	get_tree().quit()
