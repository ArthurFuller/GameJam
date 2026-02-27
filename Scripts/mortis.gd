extends Area2D

@onready var morrendo: AudioStreamPlayer2D = $morrendo

func _on_body_entered(body: Node2D) -> void:
	body.reset_level()
