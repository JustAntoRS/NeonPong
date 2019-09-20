extends Node2D

signal load_ready

#Nodes
onready var circle : Sprite = $Sprite

#Variables
var grow : bool = false
var speed : Vector2 = Vector2(1.5,1.5)
var max_size : Vector2 = Vector2(2.2,2.2)

func _process(delta: float) -> void:
	if grow:
		circle.scale += speed * delta
		
	
	if circle.scale > max_size:
		SceneLoader.load_scene(DataManager.sceneToLoad)

func start_grow():
	grow = true
