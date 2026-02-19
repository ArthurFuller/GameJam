extends CharacterBody2D

@export var speed:float = 200.0
@export var jump_force:float = -400.0
@export var gravity:float = 900.0


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	velocity.y += gravity * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	
	if (Input.is_action_just_pressed("ui_accept") && is_on_floor()):
		velocity.y = jump_force
		
		
	move_and_slide()
	
	if is_on_floor() && velocity.y > 0:
		velocity.y = 0
		
		
