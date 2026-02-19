extends Area2D

@onready var game = get_node("/root/Game")

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		print("Algo entrou:", body.name)
		game.points += 1
		queue_free()
