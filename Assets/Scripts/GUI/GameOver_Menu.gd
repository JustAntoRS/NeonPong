extends Control


onready var Transition : Node2D = $Transition_In

func _ready() -> void:
	#Change Player 1 text to Player 2 text
	if DataManager.Winner == 2:
		$GUI/VBoxContainer/P1_Win.visible = false
		$GUI/VBoxContainer/P2_Win.visible = true

func _on_Menu_Button_pressed() -> void:
	DataManager.sceneToLoad = "res://Assets/Scenes/MainScenes/MainMenu.tscn"
	Transition.start_grow()


func _on_Exit_Button_pressed() -> void:
	get_tree().quit()


