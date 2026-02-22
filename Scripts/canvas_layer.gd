extends CanvasLayer

@onready var pause := $Panel

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		pause.visible = get_tree().paused

func _on_despausar_pressed() -> void:
	get_tree().paused = false
	pause.visible = false
	

func _on_fechar_jogo_pressed() -> void:
	get_tree().quit()
