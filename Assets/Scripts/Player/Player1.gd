extends "res://Assets/Scripts/Player/Pad.gd"

var NewPosition : float 


func _process(delta: float) -> void:
	#Set new position to the actual position of the pad (y axis only)
	NewPosition = position.y
	
	#Modify the variable with the new position we will move
	if Input.is_action_pressed("up2"):
		NewPosition -= Speed
	if Input.is_action_pressed("down2"):
		NewPosition += Speed
	
	#Apply the position 
	position.y = NewPosition

func _on_2PlayersBall_score() -> void:
	position = initial_pos
