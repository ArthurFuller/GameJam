extends StaticBody2D

var can_destroy:bool = false
var is_preview:bool = false
var can_place:bool = true

func _ready() -> void:
	
	if is_preview:
		modulate = Color(1, 1, 1, 0.6)
		
		collision_layer = 0
		collision_mask = 0
		
		return
	
	await get_tree().create_timer(0.15).timeout
	can_destroy = true

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	
	if not can_destroy:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			queue_free()


func _on_placement_area_body_entered(body: Node2D) -> void:
	if not is_preview:
		return
	
	can_place = false
	modulate = Color(1, 0.3, 0.3, 0.6)
	

func _on_placement_area_body_exited(body: Node2D) -> void:
	if not is_preview:
		return
		
	if $PlacementArea.get_overlapping_bodies().is_empty():
		can_place = true
		modulate = Color(0.3, 1, 0.3, 0.6)
