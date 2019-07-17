extends "res://Assets/Scripts/Player/Pad.gd"

var NewPosition : float 

func _process(delta: float) -> void:
	#Set new position to the actual position of the pad (y axis only)
	NewPosition = position.y
	
	#Modify the variable with the new position we will move
	if Input.is_action_pressed("up2"):
		NewPosition -= 1 * Speed
	if Input.is_action_pressed("down2"):
		NewPosition += 1 * Speed
	
	#Apply the position 
	position = Vector2(position.x,NewPosition)
	
	#Check for screen limits
	if position.y < player_size.y/2:
		position.y = player_size.y/2
	if position.y > screen_size.y - player_size.y / 2:
		position.y = screen_size.y - player_size.y / 2


func _on_2PlayersBall_score() -> void:
	position = initial_pos
