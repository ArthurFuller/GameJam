extends Node

var current_level := 1
var total_levels := 6

func load_next_level():
	current_level += 1
	
	if current_level > total_levels:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/fimdejogo.tscn")
		return
		
	var path = "res://scenes/Gameplay/gameplay_" + str(current_level) + ".tscn"
	TransitionManager.fade_to_scene(str(path))
	
