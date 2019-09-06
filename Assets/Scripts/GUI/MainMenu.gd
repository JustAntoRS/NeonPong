extends MarginContainer

# Nodes
onready var InitialPanel : Control = $VerticalContainer/VerticalContainer2/InitialButtons
onready var OptionPanel : Control = $VerticalContainer/VerticalContainer2/OptionsButtons
onready var PlayersPanel : Control = $VerticalContainer/VerticalContainer2/PlayButtons

onready var InfoLabel : Control = $VerticalContainer/InfoLabel
onready var OptionsButtons : OptionButton = $VerticalContainer/VerticalContainer2/OptionsButtons/VBoxContainer/OptionButton
onready var VolumenChangedSound : AudioStreamPlayer2D = $VerticalContainer/VerticalContainer2/OptionsButtons/VBoxContainer/SoundSlider/Sound

#Variables
onready var AudioBusID : int = AudioServer.get_bus_index("Master")

func _ready() ->void:
	OptionsButtons.add_item("FullScreen",0)
	OptionsButtons.add_item("Window",1)
	
func _on_ExitButton_pressed() -> void:
	#Temporal, must think about saving high-scores
	get_tree().quit()

func _on_OptionButton_item_selected(ID : int) -> void:
	if ID==1:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true

func _on_SoundSlider_value_changed(value: float) -> void:
	if value < 0:
		AudioServer.set_bus_mute(AudioBusID,true)
	else:
		AudioServer.set_bus_mute(AudioBusID,false)
		AudioServer.set_bus_volume_db(AudioBusID,  value - 10)

func _on_SoundSlider_gui_input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		VolumenChangedSound.play()

func _on_Button_1P_pressed() -> void:
	SceneLoader.load_scene("res://Assets/Scenes/MainScenes/1Players_IA.tscn")

func _on_Button_2P_pressed() -> void:
	SceneLoader.load_scene("res://Assets/Scenes/MainScenes/2Players_Local.tscn")

#Function called when the Play and the Back button in the Players Panel are pressed
func _on_PlayButton_pressed() -> void:
	change_panels(PlayersPanel,InitialPanel)
	#SceneLoader.load_scene("res://Assets/Scenes/MainScenes/2Players_Local.tscn")


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
