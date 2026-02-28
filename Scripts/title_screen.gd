extends ColorRect

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var canvas_layer = $CanvasLayer
@onready var tela_preta = $CanvasLayer/ColorRect
@onready var anim_player = $AnimationPlayer
@onready var audio_transicao = $CanvasLayer/ColorRect/AudioStreamPlayer2D


func _on_play_button_button_down() -> void:
	play_audio()
	await iniciar_transicao()
	get_tree().change_scene_to_file("res://scenes/Gameplay/gameplay_1.tscn")

func _on_credits_button_button_down() -> void:
	play_audio()
	get_tree().change_scene_to_file("res://scenes/TELAS/Options.tscn")
	
func _on_quit_button_button_down() -> void:
	play_audio()
	get_tree().quit()

func play_audio():
	audio.play()

func iniciar_transicao():
	anim_player.play("cutscene")
	
	await anim_player.animation_finished
