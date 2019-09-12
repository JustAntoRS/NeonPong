extends Control

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DataManager.Winner == 2:
		$GUI/VBoxContainer/P1_Win.visible = false
		$GUI/VBoxContainer/P2_Win.visible = true

func _on_Menu_Button_pressed() -> void:
	SceneLoader.load_scene("res://Assets/Scenes/MainScenes/MainMenu.tscn")


func _on_Exit_Button_pressed() -> void:
	get_tree().quit()
