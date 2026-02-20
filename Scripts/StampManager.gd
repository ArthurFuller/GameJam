extends Node2D

@export var platform_normal: PackedScene
@export var platform_bounce: PackedScene

var ghost = null
var selected_scene: PackedScene = null

var current_mode = ""

func _process(delta: float) -> void:
	if ghost:
		ghost.global_position = get_global_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if ghost and ghost.can_place:
			place_platform()
		
		elif current_mode == "sticky":
			apply_sticky()


func place_platform():
	if not selected_scene:
		return
		
	var instance = selected_scene.instantiate()
	instance.global_position = ghost.global_position
	get_tree().current_scene.add_child(instance)

func apply_sticky():
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_bodies = true
	query.collide_with_areas = true
	
	var result = space_state.intersect_point(query)
	
	if result.is_empty():
		return
		
	var collider = result[0].collider
	
	if collider.has_method("activate_sticky"):
		if collider.get_node("StickyArea").is_sticky:
			collider.deactivate_sticky()
		else:
			collider.activate_sticky()

func create_ghost(scene: PackedScene):
	if ghost:
		ghost.queue_free()
		
	selected_scene = scene
	ghost = scene.instantiate()
	ghost.is_preview = true
	add_child(ghost)

func clear_ghost():
	if ghost:
		ghost.queue_free()
		ghost = null
		
	selected_scene = null

func _on_platform_normal_button_pressed() -> void:
	current_mode = "platform_normal"
	create_ghost(platform_normal)
	print("Carimbo Normal")


func _on_bounce_platform_button_pressed() -> void:
	current_mode = "platform_bounce"
	create_ghost(platform_bounce)
	print("Carimbo Bounce")


func _on_sticky_wall_button_pressed() -> void:
	current_mode = "sticky"
	print("Efeito Sticky")
	clear_ghost()
