extends CharacterBody2D

@export var speed:float = 200.0
@export var jump_force:float = -400.0
@export var gravity:float = 900.0

@export var wall_jump_force:float = -450.0
@export var wall_jump_push:float = 250.0

var can_wall_jump:bool = false

func bounce(force: float):
	velocity.y = force

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	
	if can_wall_jump and not is_on_floor():
		velocity.y = min(velocity.y, 60)
	
	if (Input.is_action_just_pressed("ui_accept")):
		if is_on_floor():
			velocity.y = jump_force
			
		elif can_wall_jump:
			var collision = get_last_slide_collision()
			if collision:
				var normal = collision.get_normal()
				
				velocity.y = wall_jump_force
				velocity.x = normal.x * wall_jump_push
		
		
		
	move_and_slide()
	
	if is_on_floor() and velocity.y >= 0:
		var collision = get_last_slide_collision()
		
		if collision:
			var collider = collision.get_collider()
			
			if collider.is_in_group("bounce"):
				velocity.y = -900.0
		
		
