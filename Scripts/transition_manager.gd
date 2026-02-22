extends Node2D

var scene: String

func fade_to_scene(new_scene: String) -> void:
	scene = new_scene
	$TransitionManager/Animation.play("Fade")
	

func change_scene() -> void:
	get_tree().change_scene_to_file(scene)
