extends Area2D

var is_sticky:bool = false
var original_color:Color

@onready var game = get_node("/root/Game")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

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
	game.points -= 1

	update_animation()

func deactivate():
	monitoring = false
	is_sticky = false
	modulate = original_color
	game.points += 1
	update_animation()

func _on_body_entered(body: Node2D) -> void:
	print ("Entrou:", body.name)
	if body.is_in_group("Player") and is_sticky:
		print("ATIVANDO WALL JUMP")
		body.can_wall_jump = true


func _on_body_exited(body: Node2D) -> void:
		if body.is_in_group("Player"):
			body.can_wall_jump = false
			if  "is_wall_jumping" in body:
				body.is_wall_jumping = false
				

func update_animation():
	
	var previous_animation = sprite.animation
	var new_animation: String
	
	if is_sticky == true:
		new_animation = "carimbo"
	else:
			new_animation = "nada"
	if sprite.animation != new_animation:
		sprite.play(new_animation)
