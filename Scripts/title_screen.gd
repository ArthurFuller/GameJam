extends ColorRect

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _on_play_button_button_down() -> void:
	play_audio()
	get_tree().change_scene_to_file("res://scenes/Gameplay/gameplay_1.tscn")

func _on_credits_button_button_down() -> void:
	play_audio()
	get_tree().change_scene_to_file("res://scenes/TELAS/Options.tscn")
	
func _on_quit_button_button_down() -> void:
	play_audio()
	get_tree().quit
	
func play_audio():
	audio.play()
