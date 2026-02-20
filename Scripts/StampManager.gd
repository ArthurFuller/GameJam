extends Node2D

@export var platform_normal: PackedScene
@export var platform_bounce: PackedScene


var current_mode = ""

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if current_mode == "platform_normal":
			spawn_object(platform_normal)
			
		elif current_mode == "platform_bounce":
			spawn_object(platform_bounce)
			
		elif current_mode == "sticky":
			apply_sticky()


func spawn_object(scene: PackedScene):
	
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = true
	
	var result = space_state.intersect_point(query)
			
	if result.is_empty():
		var instance = scene.instantiate()
		instance.global_position = get_global_mouse_position()
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

func _on_platform_normal_button_pressed() -> void:
	current_mode = "platform_normal"
	print("Carimbo Normal")


func _on_bounce_platform_button_pressed() -> void:
	current_mode = "platform_bounce"
	print("Carimbo Bounce")


func _on_sticky_wall_button_pressed() -> void:
	current_mode = "sticky"
	print("Efeito Sticky")
