extends KinematicBody2D

"""
Generic ball implementation with methods to stop the ball and assign a 
random movement direction between LEFT of RIGTH and code move 
the ball and to detect and react to colissions with pads or any other objects
"""
var Strength : float = 1000
var Direction : Vector2
var screen_size : Vector2
var PadCollisionSound : AudioStreamPlayer2D
var ScoreSound : AudioStreamPlayer2D
var RestartTimer : Timer

func _ready() -> void:
	#Get Screen size 
	screen_size = get_viewport_rect().size
	#Get Nodes
	PadCollisionSound = $PadCollisionSound
	ScoreSound = $ScoreSound
	RestartTimer = $RestartTimer
	
func _process(delta: float) -> void:
	#Move the ball
	var Collision : KinematicCollision2D = move_and_collide((Direction * Strength) * delta)
	#Check for collision 
	if Collision != null:
		#Check if the object collider it's a pad (the only one with the bounce method)
		if  Collision.collider.has_method("bounce"):
			#Play Hit Pad Sound only if it's not already playing
			if !PadCollisionSound.is_playing():
				PadCollisionSound.play()
			#Get the point of collision relative to pad
			var colPoint = Collision.position - Collision.collider.get("position")
			#Calculate new Direction given a point
			Direction = (Collision.collider.bounce(colPoint) + Collision.normal).normalized()
		else:
			Direction += Collision.normal
			Direction = Direction.normalized()
	#Set collision back to null
	Collision = null
	
#This function is automatically called when the Timer noche reaches 0
func randomDirection() -> void:
	#Make sure we are generating random numbers
	randomize()
	#Choose a random initial direction 
	if randi() % 2 == 0:
		Direction = Vector2.RIGHT
	else:
		Direction = Vector2.LEFT

func stop() -> void:
	Direction = Vector2.ZERO