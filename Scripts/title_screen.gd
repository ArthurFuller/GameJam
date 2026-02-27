extends ColorRect

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/Gameplay/gameplay_1.tscn")

func _on_credits_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/TELAS/Options.tscn")
	
func _on_quit_button_button_down() -> void:
	get_tree().quit
