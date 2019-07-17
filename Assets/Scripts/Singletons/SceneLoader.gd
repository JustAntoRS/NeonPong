extends Node

"""
Script that acts as a Singleton and provides tools to change the scene
safely based on the documentation: 

http://docs.godotengine.org/en/latest/getting_started/step_by_step/singletons_autoload.html

Take in mind that since the scenes in the game are simple this method
doesn't provide with a loading screen since the loadings are almost 
instants, to see how to produce loading screens and a better loading
method see:

http://docs.godotengine.org/en/latest/tutorials/io/background_loading.html#doc-background-loading
"""

var current_scene : Node = null

func _ready() -> void:
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)
	
func load_scene(path : String) -> void:
	#Call the actual function when it is safe to do it
	#We are sure that no code from the current scene is running
	call_deferred("_deferred_load_scene",path)

func _deferred_load_scene(path : String) -> void:
	#Free the scene
	current_scene.free()
	#Load the scene
	var s = ResourceLoader.load(path)
	#Instace the loaded scene
	current_scene = s.instance()
	#Add it as a child of root node
	get_tree().get_root().add_child(current_scene)
	#Compatibility with the SceneTree.change_scene() API
	get_tree().set_current_scene(current_scene)