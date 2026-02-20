extends Area2D

var is_sticky:bool = false
var original_color:Color

func _ready() -> void:
	monitoring = false
	original_color = modulate
	

func _process(delta: float) -> void:
	pass

	
func activate():
	print("MONITORING LIGADO")
	monitoring = true
	is_sticky = true
	modulate = Color(0.0, 10.55, 0.0, 1.0)
	

func deactivate():
	monitoring = false
	is_sticky = false
	modulate = original_color

func _on_body_entered(body: Node2D) -> void:
	print ("Entrou:", body.name)
	if body.is_in_group("Player") and is_sticky:
		print("ATIVANDO WALL JUMP")
		body.can_wall_jump = true

func _on_body_exited(body: Node2D) -> void:
		if body.is_in_group("Player"):
			body.can_wall_jump = false
