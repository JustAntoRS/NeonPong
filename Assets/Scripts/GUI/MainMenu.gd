extends MarginContainer

# Nodes
onready var InitialPanel : Control = $VerticalContainer/VerticalContainer2/InitialButtons
onready var OptionPanel : Control = $VerticalContainer/VerticalContainer2/OptionsButtons
onready var PlayersPanel : Control = $VerticalContainer/VerticalContainer2/PlayButtons
onready var DifficultyPanel : Control = $VerticalContainer/VerticalContainer2/DifficultyButtons

onready var InfoLabel : Control = $VerticalContainer/InfoLabel
onready var OptionsButtons : OptionButton = $VerticalContainer/VerticalContainer2/OptionsButtons/VBoxContainer/OptionButton
onready var VolumenChangedSound : AudioStreamPlayer2D = $VerticalContainer/VerticalContainer2/OptionsButtons/VBoxContainer/SoundSlider/Sound
onready var Label_Points : Label = $VerticalContainer/VerticalContainer2/PlayButtons/VBoxContainer/HBoxContainer2/Label

onready var Transition : Node2D = $"../Transition_In"

#Variables
onready var AudioBusID : int = AudioServer.get_bus_index("Master")


func _ready() ->void:
	#Add the options to the button
	OptionsButtons.add_item("FullScreen",0)
	OptionsButtons.add_item("Window",1)
	#Set the difficulty to god for the background
	DataManager.Difficulty == "god"
	
func _on_ExitButton_pressed() -> void:
	get_tree().quit()

# Function that changes to full screen or windowed depending of the option selected
func _on_OptionButton_item_selected(ID : int) -> void:
	if ID==1:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true

#Function that change the volume or mute it based on the slider
func _on_SoundSlider_value_changed(value: float) -> void:
	if value < 0:
		AudioServer.set_bus_mute(AudioBusID,true)
	else:
		AudioServer.set_bus_mute(AudioBusID,false)
		AudioServer.set_bus_volume_db(AudioBusID,  value - 10)

#Function that plays a sound every time a click is released in the sound slider
func _on_SoundSlider_gui_input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		VolumenChangedSound.play()

#Function called when the Play and the Back button in the Players Panel are pressed
func _on_PlayButton_pressed() -> void:
	#Set max points to default value again
	DataManager.MaxPoints = 7
	change_panels(PlayersPanel,InitialPanel)

#Function called when the Options and the Back button in the Options Panel are pressed
func Options_pressed() -> void:
	change_panels(OptionPanel,InitialPanel)

#Generic function to change between panels
func change_panels(Panel1 : Control, Panel2: Control) -> void:
	Panel1.visible = !Panel1.visible
	Panel2.visible = !Panel2.visible
	
	if InitialPanel.visible:
		InfoLabel.visible = true
	else:
		InfoLabel.visible = false

func _on_Button_1P_pressed() -> void:
	change_panels(DifficultyPanel,PlayersPanel)

func _on_Button_2P_pressed() -> void:
	DataManager.sceneToLoad = "res://Assets/Scenes/MainScenes/2Players_Local.tscn"
	Transition.start_grow()

func _on_EasyButton_pressed() -> void:
	DataManager.Difficulty = "easy"
	DataManager.sceneToLoad = "res://Assets/Scenes/MainScenes/1Players_IA.tscn"
	Transition.start_grow()

func _on_NormalButton_pressed() -> void:
	DataManager.Difficulty = "normal"
	DataManager.sceneToLoad = "res://Assets/Scenes/MainScenes/1Players_IA.tscn"
	Transition.start_grow()

func _on_HardButton_pressed() -> void:
	DataManager.Difficulty = "hard"
	DataManager.sceneToLoad = "res://Assets/Scenes/MainScenes/1Players_IA.tscn"
	Transition.start_grow()

func _on_BackDiff_pressed() -> void:
	change_panels(PlayersPanel,DifficultyPanel)

func _on_minus_button_pressed() -> void:
	if DataManager.MaxPoints > 1:
		DataManager.MaxPoints -= 1
		Label_Points.text = str(DataManager.MaxPoints)

func _on_plus_button_pressed() -> void:
	DataManager.MaxPoints += 1
	Label_Points.text = str(DataManager.MaxPoints)
