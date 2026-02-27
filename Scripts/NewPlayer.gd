extends CharacterBody2D

@export var speed:float = 200.0
@export var jump_force:float = -400.0
const GRAVIDADE = 4000

@export var wall_jump_force: float = -700
@export var wall_jump_speed: float = 500
@export var wall_slide_speed:float = 50.0

var can_move: bool
var can_wall_jump:bool = false
var is_wall_sliding: bool = false
var wall_direction: int = 0
var is_moving:bool 

@onready var ray_left: RayCast2D = $ray_left
@onready var ray_right: RayCast2D = $ray_right

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var debug_label: Label = $Label

@onready var andando: AudioStreamPlayer2D = $andando
@onready var pulando: AudioStreamPlayer2D = $pulando
@onready var boing: AudioStreamPlayer2D = $boing
@onready var morrendo: AudioStreamPlayer2D = $morrendo

func _ready() -> void:
	can_move = false
	await get_tree().create_timer(0.5).timeout
	can_move = true
	print(sprite.sprite_frames)

func bounce(force: float):
	velocity.y = force

func _physics_process(delta: float) -> void:
	if not can_move:
		return
	
	if not is_on_floor():
		velocity.y += GRAVIDADE * delta
	
	if not is_wall_sliding:
		var direction = Input.get_vector("Left", "Right", "ui_up", "ui_down")
		var horizontal_dir = Vector2(direction.x, 0).normalized()
		velocity.x = horizontal_dir.x * speed
		
		if horizontal_dir.x != 0 and is_on_floor():
			is_moving = true
		else:
			is_moving = false

	if (Input.is_action_just_pressed("Jump")) and is_on_floor():
		pulando.play()
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
	update_animation()
	
	if is_on_floor() and velocity.y >= 0:
		var collision = get_last_slide_collision()
		
		if collision:
			var collider = collision.get_collider()
			
			if collider.is_in_group("bounce"):
				collider.play_animation()
				boing.play()
				velocity.y = -1700.0

func start_wall_slide(left, right):
	is_wall_sliding = true
	velocity.y = min(velocity.y, wall_slide_speed)
	wall_direction = 1 if left else -1

func stop_wall_slide():
	is_wall_sliding = false
	wall_direction = 0

func play_sound():
	if is_moving:
		if not andando.playing:
			andando.play()


func update_animation():
	
	var previous_animation = sprite.animation
		
	var new_animation: String
	
	if is_on_floor():
		if abs(velocity.x) < 1:
			new_animation = "idle"
		else:
			new_animation = "walk"
	else:
		var touching_wall = ray_left.is_colliding() or ray_right.is_colliding()
		
		if touching_wall and velocity.y > 0:
			new_animation = "wall_slide"
		elif velocity.y < 0:
			new_animation = "jump"
		else:
			new_animation = "fall"
	
	if sprite.animation != new_animation:
		sprite.play(new_animation)
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x > 0
		
	debug_label.text = sprite.animation

func reset_level():
	get_tree().reload_current_scene()
