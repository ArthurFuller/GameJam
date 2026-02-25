extends ColorRect


func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/Gameplay/gameplay_1.tscn")

func _on_quit_button_down() -> void:
	get_tree().quit()

func _on_options_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/TELAS/Options.tscn")
