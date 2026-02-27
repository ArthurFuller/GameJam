extends Node2D

func _ready():
	print("Cena carregada, iniciando vídeo...")
	$Control/VideoStreamPlayer.play()
	
func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://scenes/TELAS/TitleScreen.tscn")
