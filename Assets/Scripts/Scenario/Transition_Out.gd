extends Node2D

onready var circle : Sprite = $Sprite

var speed : Vector2 = Vector2(1.5,1.5)
var min_size : Vector2 = Vector2(0,0)
var dwarf : bool = true

func _process(delta: float) -> void:
	if dwarf:
		circle.scale -= speed * delta
	
	if circle.scale < min_size:
		dwarf = false
		circle.scale = Vector2(0,0)
