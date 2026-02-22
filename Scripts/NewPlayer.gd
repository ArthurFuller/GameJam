extends CharacterBody2D

@export var speed:float = 200.0
@export var jump_force:float = -400.0
@export var gravity:float = 900.0

@export var wall_jump_force: float = -700
@export var wall_jump_speed: float = 500
@export var wall_slide_speed:float = 50.0


var can_wall_jump:bool = false
var is_wall_sliding: bool = false
var wall_direction: int = 0

@onready var ray_left: RayCast2D = $ray_left
@onready var ray_right: RayCast2D = $ray_right

func bounce(force: float):
	velocity.y = force

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if not is_wall_sliding:
		var direction = Input.get_vector("Left", "Right", "ui_up", "ui_down")
		var horizontal_dir = Vector2(direction.x, 0).normalized()
		velocity.x = horizontal_dir.x * speed

	if (Input.is_action_just_pressed("Jump")) and is_on_floor():
		velocity.y = jump_force
	
	if is_wall_sliding and Input.is_action_just_pressed("Jump"):
		velocity = Vector2(wall_jump_speed * wall_direction, wall_jump_force)
		#stop_wall_slide()
		
	
	var is_touching_left_wall = ray_left.is_colliding()
	var is_touching_right_wall = ray_right.is_colliding()
	
	if (is_touching_left_wall or is_touching_right_wall) and not is_on_floor() and can_wall_jump and velocity.y > 0:
		start_wall_slide(is_touching_left_wall, is_touching_right_wall)
	elif is_wall_sliding and not (is_touching_left_wall or is_touching_right_wall):
		stop_wall_slide()
			
		
		
	move_and_slide()
	
	if is_on_floor() and velocity.y >= 0:
		var collision = get_last_slide_collision()
		
		if collision:
			var collider = collision.get_collider()
			
			if collider.is_in_group("bounce"):
				velocity.y = -900.0
				

func start_wall_slide(left, right):
	is_wall_sliding = true
	velocity.y = min(velocity.y, wall_slide_speed)
	wall_direction = 1 if left else -1
		

func stop_wall_slide():
	is_wall_sliding = false
	wall_direction = 0
