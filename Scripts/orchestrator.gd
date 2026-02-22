extends Node

@onready var options_menu = $OptionsMenu
@onready var title_screen_menu = $TitleScreen


func _on_play_pressed() -> void:
	TransitionManager.fade_to_scene("res://scenes/game.tscn")
	#get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed() -> void:
	title_screen_menu.visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_title_screen_menu_pressed() -> void:
	title_screen_menu.visible = true
