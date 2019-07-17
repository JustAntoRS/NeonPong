extends StaticBody2D

"""
Generic pad implementation with method to bounce the ball
"""

var screen_size : Vector2
var player_size : Vector2 setget ,player_size_get
var Speed : float = 12
var initial_pos : Vector2

#Basic Funcionalities

func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_size = $Sprite.get_rect().size * $Sprite.scale
	initial_pos = position
	
func player_size_get():
	return player_size
	
func bounce (point : Vector2) -> Vector2:
	#Initialize result var
	var result : float = 0
	#Check where the ball hit
	if point.y < -60:
		result = -1
	elif point.y < -20 && point.y >= -60:
		result = -0.5
	elif point.y > 20 && point.y <= 60:
		result = 0.5
	elif point.y > 60:
		result = 1
	
	#We add some randomization
	result += rand_range(-0.3,0.3)
	
	#Return the vector result
	return  Vector2(0,result)