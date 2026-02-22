extends Node

var current_level := 1
var total_levels := 6

func load_next_level():
	current_level += 1
	
	if current_level > total_levels:
		print("Fim do Jogo")
		return
		
	var path = "res://Scenes/gameplay_" + str(current_level) + ".tscn"
	get_tree().call_deferred("change_scene_to_file",path)
